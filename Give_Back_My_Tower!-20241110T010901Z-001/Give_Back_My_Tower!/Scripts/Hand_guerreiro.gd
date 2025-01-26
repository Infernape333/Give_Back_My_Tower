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

func atk() -> void:
	$"..".is_attacking = true
	$CollisionPolygon2D.disabled = false
	attack.stop()
	attack.play("attack")
	await attack.animation_finished
	$CollisionPolygon2D.disabled = true
	$"..".is_attacking = false

func _on_timer_timeout():
	atk()
