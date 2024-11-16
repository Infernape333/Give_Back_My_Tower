extends Area2D

var speed: float = 200
var direction: Vector2 = Vector2.RIGHT:

	set(value):
		direction = value
		if $AnimatedSprite2D.animation != "IceSpikes":
			rotation = direction.angle()

func _physics_process(delta):
	position += speed * direction * delta
	 
func play(animation_name = "FireBolt"):
	$AnimatedSprite2D.play(animation_name)
	
func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
