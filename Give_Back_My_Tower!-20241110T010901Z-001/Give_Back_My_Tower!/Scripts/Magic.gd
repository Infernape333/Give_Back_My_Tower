extends Area2D

var speed: float = 200
var MagicType: String = "FireBolt"

var direction: Vector2 = Vector2.RIGHT:

	set(value):
		direction = value
		rotation = direction.angle()

func _physics_process(delta):
	position += speed * direction * delta
	 
func play(animation_name = "FireBolt"):
	$AnimatedSprite2D.play(animation_name)
	
func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()


func _on_body_entered(body):
	if body.is_in_group("enemies"):
		if $AnimatedSprite2D.animation == "FireBolt":
			body.hurtFire()
		elif $AnimatedSprite2D.animation == "IceSpikes":
			body.hurtIce()
		elif $AnimatedSprite2D.animation == "DarkSkull":
			body.hurtDark()
		else:
			body.hurt()
		queue_free()
