extends CharacterBody2D


@export var speed: float = 42
@onready var hand: Node2D = get_node("Hand")
@onready var health: ProgressBar = get_node("CanvasLayer/HealthBar")
@onready var Camera: Camera2D = get_node("Camera2D")
@export var Magic : PackedScene

var is_inicial_scene: bool = false
var hp = VariaveisGlobais.current_life
var is_dead = false
var is_hurt = false

var is_attacking: bool = false
var is_skill: bool = false

var mouse_sensitivity := 45.0
var x_axis
var y_axis
var deadzone := 1.0

func _ready():
	if get_tree().current_scene.name == "Node2D":
		is_inicial_scene = true
		$CanvasLayer/SkillBar.visible = false
		$Hand.visible = false
		adjust_camera_for_lobby()
	else: 
		is_inicial_scene = false
		adjust_camera_for_gameplay()

func _physics_process(delta) -> void:
	if is_dead:
		return
	if is_hurt:
		return
	
	hand.colision_update(get_direction(),get_mouse_position())
	if not is_attacking:
		move()
		if velocity.length() > 0:
			$PlayerAnm.play("Walking")
		else:
			$PlayerAnm.play("Idle")

		if get_direction().x < 0:
			$PlayerAnm.flip_h = true
		elif get_direction().x > 0:
			$PlayerAnm.flip_h = false
			
		# Aplica zona morta para evitar drift no analógico
		var move_x = 0.0 if abs(x_axis) < deadzone else x_axis
		var move_y = 0.0 if abs(y_axis) < deadzone else y_axis

		# Se houver movimento, atualiza a posição do mouse
		if move_x != 0.0 or move_y != 0.0:
			var mouse_pos = get_viewport().get_mouse_position()
			var new_mouse_pos = mouse_pos + Vector2(move_x, move_y) * mouse_sensitivity * delta * 60  # Fator de ajuste
			Input.warp_mouse(new_mouse_pos)

func _input(event):
	if event is InputEventJoypadMotion:
		if event.axis == 2:  # Analógico direito - eixo X
			x_axis = event.axis_value
		elif event.axis == 3:  # Analógico direito - eixo Y
			y_axis = event.axis_value

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
	
func block_attack(animation_name = "blockAttack"):
	if is_inicial_scene:
		return
		
	is_attacking = true
	is_skill = true
	$PlayerAnm.stop()
	$PlayerAnm.play(animation_name)
	await $PlayerAnm.animation_finished
	is_attacking = false
	is_skill = false
	
func vortex_blade(animation_name = "vortexBlade"):
	if is_inicial_scene:
		return
		
	is_attacking = true
	is_skill = true
	$PlayerAnm.stop()
	$PlayerAnm.play(animation_name)
	await $PlayerAnm.animation_finished
	is_attacking = false
	is_skill = false

func flaming_blade(animation_name = "flamingBlade"):
	if is_inicial_scene:
		return
		
	is_attacking = true
	is_skill = true
	$PlayerAnm.stop()
	$PlayerAnm.play(animation_name)
	await $PlayerAnm.animation_finished
	is_attacking = false
	is_skill = false
	
	if is_inicial_scene:
		return
		
	var MagicAtk = Magic.instantiate()
	
	MagicAtk.play(animation_name)
	
	MagicAtk.position = global_position
	MagicAtk.direction = (get_global_mouse_position() - global_position).normalized()
	
	get_tree().current_scene.call_deferred("add_child",MagicAtk)

func adjust_camera_for_lobby():
	Camera.zoom = Vector2(4.0, 4.0)  

func adjust_camera_for_gameplay():
	Camera.zoom = Vector2(6, 6)  
