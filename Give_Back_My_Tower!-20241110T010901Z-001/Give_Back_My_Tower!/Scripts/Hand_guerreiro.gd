extends Node2D

var is_in_initial_scene: bool = false
@onready var timer: Timer = get_node("Timer")

@onready var attack = $"../PlayerAnm"

var facing_right = true
@onready var sword_area = $Area2D
@onready var collision_polygon = $Area2D/CollisionPolygon2D

func _ready():
	if get_tree().current_scene.name == "Node2D":
		is_in_initial_scene = true
	else: 
		is_in_initial_scene = false
	timer.wait_time = VariaveisGlobais.atk_spd
	
	collision_polygon.disabled = true
	
	
func colision_update(attack_direction: Vector2, direction: Vector2) -> void:
	# Ajusta o flip e posição da colisão (CollisionShape2D)
	flip_collision_polygon(collision_polygon, attack_direction)
		
func flip_collision_polygon(collision_polygon: CollisionPolygon2D, attack_direction: Vector2) -> void:
	var points = collision_polygon.polygon
	
	for i in range(points.size()):
		points[i].x = abs(points[i].x) if attack_direction.x > 0 else -abs(points[i].x)
	
	collision_polygon.polygon = points



func atk() -> void:
	$"..".is_attacking = true
	collision_polygon.disabled = false
	attack.stop()
	attack.play("attack")
	await attack.animation_finished
	collision_polygon.disabled = true
	$"..".is_attacking = false

func _on_timer_timeout():
	atk()
