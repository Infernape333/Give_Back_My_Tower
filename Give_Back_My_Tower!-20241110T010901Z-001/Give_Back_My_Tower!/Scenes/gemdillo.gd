extends CharacterBody2D

@export var spd = 10.0
@export var hp = VariaveisGlobais.enemy_Gemdillo_hp
@export var detection_range: float = 55.0
@export var dash_speed: float = 250.0
@export var dash_duration: float = 0.3
@export var wait_time: float = 0.7

@onready var hurt_direction = $ColorRect
@onready var player = get_tree().get_first_node_in_group("player")
@onready var atk_collision = $Area2D/Atk
@onready var animation = $GemAnim

var is_dashing = false
var is_waiting = false
var dir_dash = Vector2.ZERO
var coin_scene = preload("res://Scenes/coins.tscn") 
var potion_scene = preload("res://Scenes/porcao.tscn")
var drop_chance = 0.75
var pDrop_chance = 0.1
var atk_trigged = false
var is_hurt = false
var loop_frame = 3
var loop_end_fram = 8
var warning_duration = 1.0

func _ready():
	hp = VariaveisGlobais.enemy_Gemdillo_hp

func _physics_process(delta):
	if hp <= 0:
		$DamageS.disabled = true
		$Area2D/CollisionShape2D.disabled = true
		velocity = Vector2.ZERO
		return
	if is_hurt:
		velocity = Vector2.ZERO
	elif is_dashing:
		_perform_dash(delta)
	elif not is_waiting and not is_hurt:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * spd
		$GemAnim.play("Walking")
		
		if get_direction().x < 0:
			$GemAnim.flip_h = true
		elif get_direction().x > 0:
			$GemAnim.flip_h = false
		
		var distance_to_player = position.distance_to(player.position)

		if distance_to_player <= detection_range:
			is_waiting = true
			velocity = Vector2.ZERO
			_show_dash_attack_warning()
			$GemAnim.play("Attacking")
			await get_tree().create_timer(wait_time).timeout
			_start_dash()
	move_and_slide()

func get_direction() -> Vector2:
	return global_position.direction_to(player.global_position)


func reset_state():
	spd = 20
	is_hurt = false
func hurt():
	if is_hurt or $GemAnim.animation == "Attacking":
		return
	is_hurt = true
	hp -= VariaveisGlobais.dano
	print(hp)
	$GemAnim.play("Hurt")
	$Hit.play()
	spd = 0
	if hp <= 0:
		await get_tree().create_timer(.5).timeout 
		death()
	else:
		await get_tree().create_timer(0.5).timeout
		reset_state()
	

func hurtIce():
	if is_hurt or $GemAnim.animation == "Attacking":
		return
	is_hurt = true
	hp -= VariaveisGlobais.danoIce
	print(hp)
	$GemAnim.play("Hurt")
	$Hit.play()
	spd = 0
	if hp <= 0:
		await get_tree().create_timer(.5).timeout 
		death()
	else:
		await get_tree().create_timer(10).timeout
		reset_state()
	
func hurtFire():
	if is_hurt or $GemAnim.animation == "Attacking":
		return
	is_hurt = true
	hp -= VariaveisGlobais.danoFire
	print(hp)
	$GemAnim.play("Hurt")
	$Hit.play()
	spd = 0
	if hp <= 0:
		await get_tree().create_timer(.5).timeout 
		death()
	else:
		await get_tree().create_timer(1).timeout
		reset_state()
	
func hurtDark():
	if is_hurt or $GemAnim.animation == "Attacking":
		return
	is_hurt = true
	hp -= VariaveisGlobais.danoDark
	$GemAnim.play("Hurt")
	$Hit.play()
	if hp <= 0:
		spd = 0
		await get_tree().create_timer(.5).timeout 
		death()
	else:
		await get_tree().create_timer(0.5).timeout
		is_hurt = false

func death():
	$GemAnim.play("Death")
	await $GemAnim.animation_finished
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

func _show_dash_attack_warning():
	if hp <= 0:
		return
	dir_dash = (player.position - position).normalized()
	hurt_direction.rotation = dir_dash.angle()
	hurt_direction.global_position = position + dir_dash
	hurt_direction.visible = true

func _start_dash():
	is_dashing = true
	is_waiting = false
	hurt_direction.visible = false

func _perform_dash(delta):
	velocity = dir_dash * dash_speed
	dash_duration -= delta

	if dash_duration <= 0:
		velocity = Vector2.ZERO
		is_dashing = false
		is_waiting = true
		dash_duration = 0.3
		await get_tree().create_timer(wait_time).timeout
		is_waiting = false

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		body.hurt(VariaveisGlobais.enemy_Gemdillo_damage)
