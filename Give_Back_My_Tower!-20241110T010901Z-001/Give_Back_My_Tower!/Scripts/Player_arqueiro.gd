extends CharacterBody2D

@export var speed: float = 42
@onready var hand: Node2D = get_node("Hand")
@onready var health: ProgressBar = get_node("CanvasLayer/HealthBar")
@onready var Camera: Camera2D = get_node("Camera2D")
@export var Magic : PackedScene
var slime = preload("res://Scenes/slime.tscn")
var cobold = preload("res://Scenes/cobold.tscn")
var skeleton = preload("res://Scenes/skeleton.tscn")
var is_inicial_scene: bool = false
var hp = VariaveisGlobais.current_life
var is_dead = false
var is_hurt = false

var is_attacking: bool = false

func _ready():
	if get_tree().current_scene.name == "Node2D":
		is_inicial_scene = true
		$CanvasLayer/SkillBar.visible = false
		$Hand.visible = false
		adjust_camera_for_lobby()
	else: 
		is_inicial_scene = false
		adjust_camera_for_gameplay()

func _physics_process(_delta: float) -> void:
	if is_dead:
		return
	if is_hurt:
		return
	
	if not is_attacking:
		move()
		hand.animate(get_direction(),get_mouse_position())
		if velocity.length() > 0:
			$PlayerAnm.play("Walking")
		else:
			$PlayerAnm.play("Idle")

	if get_direction().x < 0:
		$PlayerAnm.flip_h = true
	elif get_direction().x > 0:
		$PlayerAnm.flip_h = false
		
func move():
	var direction: Vector2 = Vector2(
		Input.get_axis("A", "D"),
		Input.get_axis("W", "S")
	).normalized()
	
	velocity = direction * speed
	move_and_slide()

func get_direction() -> Vector2:
	return global_position.direction_to(get_mouse_position())

func get_mouse_position() -> Vector2:
	return get_global_mouse_position()

func hurt(damage: int):
	is_hurt = true
	$PlayerAnm.play("Hurt")
	VariaveisGlobais.current_life -= damage
	hp = VariaveisGlobais.current_life
	health.value = hp
	print(hp)
	VariaveisGlobais.update_health_bar()
	await get_tree().create_timer(0.5).timeout
	is_hurt = false
	die()


func heal(amout: int):
	VariaveisGlobais.current_life += amout
	if VariaveisGlobais.current_life > VariaveisGlobais.max_life:
		VariaveisGlobais.current_life = VariaveisGlobais.max_life
	health.value = VariaveisGlobais.current_life
	VariaveisGlobais.update_health_bar()

func die():
	if VariaveisGlobais.current_life <= 0:
		is_dead = true
		$PlayerAnm.play("Death")
		velocity = Vector2.ZERO
		health.value = 0
		remove_enemys()
		await get_tree().create_timer(2).timeout
		VariaveisGlobais.game_over()

func remove_enemys():
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		enemy.queue_free()    

func cone_shot(animation_name = "triptychShot"):
	if is_inicial_scene:
		return
	
	$Hand/Bow.play("attack_01")
	await get_tree().create_timer(.5).timeout
	
	var base_direction = (get_global_mouse_position() - global_position).normalized()
	var radians_offset = deg_to_rad(15)
		
	for i in range(3):
		var MagicAtk = Magic.instantiate()
		MagicAtk.play(animation_name)
		   
		# Posicionar a flecha na posição inicial do arqueiro
		MagicAtk.position = global_position
		
		# Calcular a direção da flecha com base no desvio angular
		if i == 0:
			MagicAtk.direction = base_direction.rotated(-radians_offset)  # Flecha esquerda
		elif i == 1:
			MagicAtk.direction = base_direction  # Flecha central
		elif i == 2:
			MagicAtk.direction = base_direction.rotated(radians_offset)  # Flecha direita

		# Adicionar a flecha à cena
		get_tree().current_scene.call_deferred("add_child", MagicAtk)

func explosive_arrow(count: int = 3, delay: float = 0.3, animation_name = "explosiveArrow"):
	if is_inicial_scene:
		return
		
	var MagicAtk = Magic.instantiate()
	
	$Hand/Bow.play("attack_02")
	await get_tree().create_timer(.2).timeout
	
	MagicAtk.play(animation_name)
	
	MagicAtk.position = global_position
	MagicAtk.direction = (get_global_mouse_position() - global_position).normalized()
	
	get_tree().current_scene.call_deferred("add_child",MagicAtk)

func hail_arrows(animation_name = "hailArrows"):
	if is_inicial_scene:
		return
	
	is_attacking = true
	hand.visible = false
	speed = 0
	$PlayerAnm.stop()
	$PlayerAnm.play("attack_03")
	await $PlayerAnm.animation_finished
	speed = 42
	is_attacking = false
	hand.visible = true
	#var MagicAtk = Magic.instantiate()
	#
	#MagicAtk.play(animation_name)
	#
	#MagicAtk.position = global_position
	#
	#get_tree().current_scene.call_deferred("add_child", MagicAtk)

func adjust_camera_for_lobby():
	Camera.zoom = Vector2(4.0, 4.0)  

func adjust_camera_for_gameplay():
	Camera.zoom = Vector2(6, 6)  
