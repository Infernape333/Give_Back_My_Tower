extends Node2D

var is_in_initial_scene: bool = false
@onready var timer: Timer = get_node("Timer")

@onready var attack = $"../PlayerAnm"

func _ready():
	if get_tree().current_scene.name == "Node2D":
		is_in_initial_scene = true
	else: 
		is_in_initial_scene = false
	timer.wait_time = VariaveisGlobais.atk_spd
	
#func animate(attack_direction: Vector2, direction: Vector2) -> void:
	#if attack_direction.x > 0:
		#staff.flip_v = false
	#if attack_direction.x < 0:
		#staff.flip_v = true
	#look_at(direction)

func atk() -> void:
	$"..".is_attacking = true
	attack.stop()
	attack.play("attack")
	await attack.animation_finished
	$"..".is_attacking = false

func _on_timer_timeout():
	atk()
