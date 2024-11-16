extends CharacterBody2D


@export var speed: float = 42
@onready var hand: Node2D = get_node("Hand")
@onready var health: ProgressBar = get_node("CanvasLayer/HealthBar")
@export var Magic : PackedScene
var slime = preload("res://Scenes/slime.tscn")
var cobold = preload("res://Scenes/cobold.tscn")
var skeleton = preload("res://Scenes/skeleton.tscn")
var is_inicial_scene: bool = false
var hp = VariaveisGlobais.current_life
var is_dead = false
var is_hurt = false

func _ready():
	if get_tree().current_scene.name == "Node2D":
		is_inicial_scene = true
		$CanvasLayer/SkillBar.visible = false
		$Hand.visible = false
	else: 
		is_inicial_scene = false

func _physics_process(_delta: float) -> void:
	if is_dead:
		return
	if is_hurt:
		return
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
	
func single_shot(animation_name = "FireBolt"):
	if is_inicial_scene:
		return
	var MagicAtk = Magic.instantiate()
	
	MagicAtk.play(animation_name)
	
	MagicAtk.position = global_position
	MagicAtk.direction = (get_global_mouse_position() - global_position).normalized()
	
	get_tree().current_scene.call_deferred("add_child",MagicAtk)
	
	
func multi_shot(count: int = 3, delay: float = 0.3, animation_name = "DarkSkull"):
	for i in range(count):
		single_shot(animation_name)
		await get_tree().create_timer(delay).timeout
	
func angled_shot(angle, i):
	var MagicAtk = Magic.instantiate()
	
	if i % 2 == 0:
		MagicAtk.play("IceSpikes")
	else:
		MagicAtk.play("IceSpikes")
	
	MagicAtk.position = global_position
	MagicAtk.direction = Vector2(cos(angle), sin(angle))
	
	get_tree().current_scene.call_deferred("add_child", MagicAtk)
	
func radial(count):
	if is_inicial_scene:
		return
	for i in range(count):
		angled_shot( (float(i) / count) * 2.0 * PI, i)
	
func _on_area_2d_body_entered(body):
	if body.get_name() == "Player":
		body.speed = 0
		TransitionManager.fade_to_scene("res://Scenes/floor_1.tscn")

