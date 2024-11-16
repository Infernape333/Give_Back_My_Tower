extends CharacterBody2D

@export var hp = VariaveisGlobais.BossHp
@export var spd: float = 150  # Velocidade de movimento do boss
@export var shoot_delay: float = 2.0  # Intervalo entre os disparos de magia
@export var magic_scene: PackedScene  = preload("res://Scenes/magic_evil.tscn") # Cena da magia que o boss vai disparar
@onready var player_camera = get_node("../Player/Camera2D")
var points = []
var current_point_index = 0

@onready var player = get_tree().get_first_node_in_group("player")
var target_position: Vector2
var is_moving: bool = true

func _ready():
	points.append(Vector2(382,153))
	points.append(Vector2(382, 153))
	points.append(Vector2(613, 152))
	points.append(Vector2(612, 335))
	points.append(Vector2(375, 373))
	points.append(Vector2(200, 365))
	points.append(Vector2(253, 245))
	
	move_to_random_point()
	start_shooting()
	
func move_to_random_point():
	target_position = points[randi() % points.size()]
	is_moving = true

func _physics_process(delta):
	if is_moving:
		var direction =  (target_position - global_position).normalized()
		velocity = direction * spd
		move_and_slide()
		if global_position.distance_to(target_position) < 5:
			is_moving = false
			await get_tree().create_timer(2.5).timeout
			move_to_random_point()


func start_shooting():
	while true:
		await get_tree().create_timer(shoot_delay).timeout
		shoot_magic()

func shoot_magic():
	var magic_instance = magic_scene.instantiate()
	var direction = global_position.direction_to(player.global_position).normalized()
	magic_instance.position = global_position
	magic_instance.direction = direction 
	get_tree().current_scene.call_deferred("add_child", magic_instance)

func hurt():
	hp -= VariaveisGlobais.dano
	print(hp)
	$EvilAnm.play("Hurt")
	spd = 0
	if hp <= 0:
		die()
	await get_tree().create_timer(.5).timeout
	spd = 20

func hurtIce():
	hp -= VariaveisGlobais.danoIce
	print(hp)
	$EvilAnm.play("Hurt")
	spd = 0
	if hp <= 0:
		die()
	await get_tree().create_timer(5).timeout
	spd = 20

func hurtFire():
	hp -= VariaveisGlobais.danoFire
	print(hp)
	$EvilAnm.play("Hurt")
	spd = 0
	if hp <= 0:
		die()
	await get_tree().create_timer(1).timeout
	spd = 20

func hurtDark():
	hp -= VariaveisGlobais.danoDark
	print(hp)
	$EvilAnm.play("Hurt")
	if hp <= 0:
		die()
	await get_tree().create_timer(1).timeout

func die():
	$EvilAnm.play("Death")
	await  get_tree().create_timer(0.5).timeout
	queue_free()
