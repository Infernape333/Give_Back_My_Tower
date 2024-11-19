extends CharacterBody2D

@export var spd = 15.0
@export var hp = VariaveisGlobais.enemy_Grizzly_hp
@export var detection_range: float = 35.0

@onready var player = get_tree().get_first_node_in_group("player")
@onready var atk_collision = $Area2D/Atk

var coin_scene = preload("res://Scenes/coins.tscn") 
var potion_scene = preload("res://Scenes/porcao.tscn")
var drop_chance = 0.75
var pDrop_chance = 0.1
var atk_trigged = false
var warning_duration = 1.0
var can_attack = true


func _ready():
	hp = VariaveisGlobais.enemy_Grizzly_hp
	atk_collision.disabled = true

func _physics_process(_delta):
	if spd > 0:
		$GrizzlyAnm.play("Walking")
	var direction = global_position.direction_to(player.global_position)
	velocity = direction*spd
	if get_direction().x < 0:
		$GrizzlyAnm.flip_h = true
	elif get_direction().x > 0:
		$GrizzlyAnm.flip_h = false
	move_and_slide()
	
	if not atk_trigged and global_position.distance_to(player.global_position) <= detection_range:
		spd = 0
		$GrizzlyAnm.play("Attack")
		atk_trigged = true
		await get_tree().create_timer(.8).timeout
		atk_collision.disabled = false
		spd = 15
	if can_attack and not atk_trigged and global_position.distance_to(player.global_position) <= detection_range:
		start_atk()
	elif not atk_trigged:
		move_towards_player()
	
	if hp <= 0:
		disable_all_collision()
	
	
func get_direction() -> Vector2:
	return global_position.direction_to(player.global_position)
	
func move_towards_player():
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * spd
	$GrizzlyAnm.play("Walking")
	
	if get_direction().x < 0:
		$GrizzlyAnm.flip_h = true
	elif get_direction().x > 0:
		$GrizzlyAnm.flip_h = false
	move_and_slide()

func start_atk():
	spd = 0
	atk_trigged = true
	can_attack = false
	$GrizzlyAnm.play("Attack")
	attack_sequence()

func attack_sequence():
	await get_tree().create_timer(0.8).timeout
	atk_collision.disabled = true
	await get_tree().create_timer(0.2).timeout
	atk_collision.disabled = false
	end_atk()
	
func end_atk():
	spd = 15
	atk_trigged = false
	await get_tree().create_timer(5).timeout
	can_attack = true

func disable_all_collision():
	$DamageS.disabled = true
	atk_collision.disabled = true

func hurt():
	hp -= VariaveisGlobais.dano
	print(hp)
	$GrizzlyAnm.play("Hurt")
	spd = 0
	if hp <= 0:
		death()
	await get_tree().create_timer(.5).timeout
	spd = 15

func hurtIce():
	hp -= VariaveisGlobais.danoIce
	print(hp)
	$GrizzlyAnm.play("Hurt")
	spd = 0
	if hp <= 0:
		death()
	await get_tree().create_timer(10).timeout
	spd = 15
	

func hurtFire():
	hp -= VariaveisGlobais.danoFire
	print(hp)
	$GrizzlyAnm.play("Hurt")
	spd = 0
	if hp <= 0:
		death()
	await get_tree().create_timer(1).timeout
	spd = 15
	
func hurtDark():
	hp -= VariaveisGlobais.danoDark
	$GrizzlyAnm.play("Hurt")
	if hp <= 0:
		death()
	await get_tree().create_timer(1).timeout

func death():
	$GrizzlyAnm.play("Death")
	await get_tree().create_timer(.3).timeout
	var rand = randf() 
	if rand <= drop_chance:
		drop_coin()
	if rand <= pDrop_chance:
		drop_potion()
	queue_free()


func drop_potion():
	var potion = potion_scene.instantiate()
	get_parent().add_child(potion)
	potion.position = position
	
func drop_coin():
	var coin = coin_scene.instantiate()
	get_parent().add_child(coin)
	coin.position = position 

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		body.hurt(VariaveisGlobais.enemy_Grizzly_damage)


