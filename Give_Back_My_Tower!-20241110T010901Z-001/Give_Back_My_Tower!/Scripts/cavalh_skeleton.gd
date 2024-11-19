extends CharacterBody2D


@onready var player = get_tree().get_first_node_in_group("player")
@onready var SmashT = $Smash_Timer
@onready var Area_jump = $Area2D3
@onready var hurt_direction = $ColorRect
@onready var Area_atk = $Area2D2/AreaAtk
@onready var Health_bar = $CanvasLayer/HealthBar

@export var spd = 40.0
@export var hp = VariaveisGlobais.BossHp
@export var detection_range_dash: float = 100.0
@export var detection_range_smash: float = 50.0
@export var jump_height: float = 200.0  # Altura do pulo
@export var jump_speed: float = 600.0  # Velocidade do pulo
@export var dash_speed: float = 300.0  # Aumentar a velocidade do dash
@export var wait_time: float = .7
@export var dash_duration: float = 0.3  # Aumentar a duração do dash para ir mais longe


var dir_dash = Vector2.ZERO
var is_dashing = false
var is_cone_atk = false
var is_waiting = false
var is_attacking = false
var dash_count = 0
var smash_active = false
var is_jumping = false  
var jump_timer = 0.0 

var coin_scene = preload("res://Scenes/coins.tscn") 
var potion_scene = preload("res://Scenes/porcao.tscn")

var drop_chance = 0.75
var pDrop_chance = 0.1

func _ready():
	Health_bar.init_health(hp)

func _physics_process(_delta):
	if hp <= 0:
		return
	if is_dashing:
		_perform_dash(_delta)
	elif is_cone_atk:
		_perform_cone_attack(_delta)
	elif is_jumping:
		_perform_jump(_delta)
	elif not is_waiting:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * spd
		$cavalhSkeleton_anim.play("Walking")
		
		if get_direction().x < 0:
			$cavalhSkeleton_anim.flip_h = true
		elif get_direction().x > 0:
			$cavalhSkeleton_anim.flip_h = false
			
		var distance_to_player = position.distance_to(player.position)
	
		if dash_count >= 3:
			SmashT.start()
		
		if dash_count >= 3 and distance_to_player <= detection_range_smash:
			is_waiting = true
			velocity = Vector2.ZERO
			print("Ativando ataque em cone")
			_show_attack_warning()
			await get_tree().create_timer(wait_time).timeout
			start_cone_atk()
			
		elif dash_count >= 3 and distance_to_player >= detection_range_dash and SmashT.timeout:
			dash_count = 0
			is_waiting = true
			velocity = Vector2.ZERO
			print("Realizando dash, contador de dash:", dash_count)
			print("oi")
			_show_dash_attack_warning()
			await get_tree().create_timer(wait_time).timeout
			_start_dash()

		elif dash_count < 3 and distance_to_player <= detection_range_dash:
			is_waiting = true
			velocity = Vector2.ZERO
			print("Realizando dash, contador de dash:", dash_count)
			_show_dash_attack_warning()
			$cavalhSkeleton_anim.play("Attacking")
			await get_tree().create_timer(wait_time).timeout
			_start_dash()
		
	move_and_slide()


func get_direction() -> Vector2:
	return global_position.direction_to(player.global_position)

func hurt():
	hp -= VariaveisGlobais.dano
	Health_bar.health = hp
	print(hp)
	if hp <= 0:
		death()
		return
	else:
		spd = 0
		await get_tree().create_timer(0.5).timeout
		spd = 40

func death():
	is_dashing = false
	is_waiting = true
	$cavalhSkeleton_anim.play("Death")
	print($cavalhSkeleton_anim.animation)
	await  $cavalhSkeleton_anim.animation_finished
	queue_free()

func hurtFire():
	hp -= VariaveisGlobais.danoFire
	Health_bar.health = hp
	print(hp)
	spd = 0
	if hp <= 0:
		death()
		return
	await get_tree().create_timer(1).timeout
	spd = 40


func hurtIce():
	hp -= VariaveisGlobais.danoIce
	Health_bar.health = hp
	print(hp)
	spd = 0
	if hp <= 0:
		death()
		return
	await get_tree().create_timer(10).timeout
	spd = 40
	

func hurtDark():
	hp -= VariaveisGlobais.danoDark
	Health_bar.health = hp
	print(hp)
	spd = 0
	if hp <= 0:
		death()
		return
	await get_tree().create_timer(.1).timeout
	spd = 40


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
		body.hurt(VariaveisGlobais.enemy_Orc_Rider_damage)

func _on_area_2d_2_body_entered(body):
	if body.is_in_group("player"):
		body.hurt(VariaveisGlobais.enemy_Orc_Rider_damage)
		if smash_active:
			SmashT.stop()
			smash_active = false
			is_waiting = false

func _on_area_2d_3_body_entered(body):
	if body.is_in_group("player"):
		body.hurt(VariaveisGlobais.enemy_Orc_Rider_damage)

func _show_dash_attack_warning():
	if hp <= 0:
		return
	dir_dash = (player.position - position).normalized()
	hurt_direction.rotation = dir_dash.angle()
	hurt_direction.global_position = position + dir_dash
	hurt_direction.visible = true

func _start_dash():
	if hp <= 0:
		death()
		return
	is_dashing = true
	is_waiting = false
	dash_count += 1
	hurt_direction.visible = false 
	

func _perform_dash(delta):
	if hp <= 0:
		death()
		return
	
	velocity = dir_dash * dash_speed
	dash_duration -= delta
	if dash_duration <= 0:
		velocity = Vector2.ZERO
		is_dashing = false
		is_waiting = true
		await get_tree().create_timer(wait_time).timeout
		is_waiting = false
		dash_duration = 0.3  

func _show_attack_warning():
	if hp <= 0:
		death()
		return
	Area_atk.visible = true

func start_cone_atk():
	if hp <= 0:
		death()
		return
	is_attacking = true
	is_cone_atk = true
	is_waiting = false
	$cavalhSkeleton_anim.play("Attacking3")
	await get_tree().create_timer(.5).timeout
	Area_atk.disabled = false
	Area_atk.visible = true
	
	SmashT.start()
	
	await get_tree().create_timer(0.2).timeout
	Area_atk.visible = false
	Area_atk.disabled = true
	
	await $cavalhSkeleton_anim.animation_finished
	is_cone_atk = false
	is_waiting = true
	
	await get_tree().create_timer(wait_time).timeout
	is_waiting = false
	dash_count = 0

func _perform_cone_attack(delta):
	if hp <= 0:
		death()
		return
	Area_atk.visible = true
	await get_tree().create_timer(0.2).timeout
	is_attacking = false
	Area_atk.visible = false

func _on_smash_timer_timeout():
	if smash_active:
		print("Jogador não entrou na área do ataque Smash. Resetando dash_count") 
		dash_count = 0
		smash_active = false
		is_waiting = false

func _perform_jump(delta):
	if hp <= 0:
		death()
		return

	# Lógica de pulo
	jump_timer += delta
	var jump_progress = jump_speed * delta - (jump_timer * 2)  # Ajuste a física do pulo

	velocity.y -= jump_progress  # Aplica o movimento vertical
	if jump_timer >= 0.5:  # Se já pulou por um tempo específico
		Area_jump.visible = true  # Ativa a área de dano durante o pulo
		$AnimationPlayer.play("Attacking3")  # Toca a animação do pulo

	if jump_timer > 1.0:  # Depois de um tempo, terminar o pulo
		is_jumping = false
		Area_jump.visible = false
		is_waiting = true

func start_jump_atk():
	if hp <= 0:
		death()
		return
	is_jumping = true
	is_waiting = false
	jump_timer = 0.0  # Resetando o timer do pulo
	$cavalhSkeleton_anim.play("Attacking3")  # Toca a animação de pulo
	await get_tree().create_timer(.5).timeout
	Area_jump.disabled = false
	Area_jump.visible = true  # Ativa a área de dano enquanto estiver no ar
	
	await get_tree().create_timer(0.5).timeout
	Area_jump.visible = false
	Area_jump.disabled = true
	
	await $cavalhSkeleton_anim.animation_finished
	is_jumping = false
	is_waiting = true
	
	await get_tree().create_timer(wait_time).timeout
	is_waiting = false
	dash_count = 0


