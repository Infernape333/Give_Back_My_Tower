extends PlayerBase


@export var speed: float = 42
@onready var hand: Node2D = get_node("Hand")
@onready var health: ProgressBar = get_node("CanvasLayer/HealthBar")
@onready var Camera: Camera2D = get_node("Camera2D")
@export var Magic : PackedScene

var slime = preload("res://Scenes/slime.tscn")
var cobold = preload("res://Scenes/cobold.tscn")
var skeleton = preload("res://Scenes/skeleton.tscn")
var is_inicial_scene: bool = false
var hp: int:
	get: return get_curr_life()
	
var is_dead = false
var is_hurt = false

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
	set_life_damage(damage)
	health.value = hp
	print(hp)
	VariaveisGlobais.update_health_bar()
	await get_tree().create_timer(0.5).timeout
	is_hurt = false
	die()

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
	
	$Hand/Staff.play("attack_01")
	
	MagicAtk.play(animation_name)
	
	MagicAtk.position = global_position
	MagicAtk.direction = (get_global_mouse_position() - global_position).normalized()
	
	get_tree().current_scene.call_deferred("add_child",MagicAtk)
	
	
func multi_shot(count: int = 3, delay: float = 0.3, animation_name = "DarkSkull"):
	if is_inicial_scene:
		return
	
	
	$Hand/Staff.play("attack_03")
	
	for i in range(count):
		var MagicAtk = Magic.instantiate()
		
		MagicAtk.play(animation_name)
	
		MagicAtk.position = global_position
		MagicAtk.direction = (get_global_mouse_position() - global_position).normalized()
	
		get_tree().current_scene.call_deferred("add_child",MagicAtk)
		await get_tree().create_timer(delay).timeout
	
func angled_shot(angle, i):
	var MagicAtk = Magic.instantiate()
	
	$Hand/Staff.play("attack_02")
	
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
		
func adjust_camera_for_lobby():
	Camera.zoom = Vector2(4.0, 4.0)  

func adjust_camera_for_gameplay():
	Camera.zoom = Vector2(6, 6)  

func push_inventory_item(inventory_item: InventoryItem, amount: int):
	inventory_item.decrease(amount)
	VariaveisGlobais.coins -= inventory_item.get_coins()
	
