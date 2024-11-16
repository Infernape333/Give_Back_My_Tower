extends Area2D

var direction: Vector2= Vector2.ZERO

func _ready():
	randomize()
	direction = global_position.direction_to(get_global_mouse_position())
	var angle = direction.angle()
	rotation_degrees = rad_to_deg(angle)

func _physics_process(delta: float):
	translate(direction * delta * 512.0)

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.hurt()
		queue_free()
