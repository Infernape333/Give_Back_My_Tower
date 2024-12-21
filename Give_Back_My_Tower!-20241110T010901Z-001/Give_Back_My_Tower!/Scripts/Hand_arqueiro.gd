extends Node2D

@onready var bow: Sprite2D = get_node("Bow")
const ARROW: PackedScene = preload("res://Scenes/arrow.tscn")
var is_in_initial_scene: bool = false
@onready var timer: Timer = get_node("Timer")

func _ready():
	if get_tree().current_scene.name == "Node2D":
		is_in_initial_scene = true
	else: 
		is_in_initial_scene = false
	timer.wait_time = VariaveisGlobais.atk_spd

func animate(attack_direction: Vector2, direction: Vector2) -> void:
	if attack_direction.x > 0:
		bow.flip_v = false
	if attack_direction.x < 0:
		bow.flip_v = true
	look_at(direction)

func atk() -> void:
	if is_in_initial_scene:
		$Timer.stop()
		return
	
	var arrow = ARROW.instantiate()
	$Shoot.play()
	arrow.global_position = global_position + Vector2(0, 0.5)
	get_tree().root.call_deferred("add_child", arrow)


func _on_timer_timeout():
	atk()
