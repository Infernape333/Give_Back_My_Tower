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
		match MagicType:
				"FireBolt":
					explosion()  # Chama a explosão
				"IceSpikes":
					body.hurtIce()
				"DarkSkull":
					body.hurtDark()
				_:
					body.hurt()
		
		$CollisionShape2D.disabled = true
		speed = 0
		if MagicType != "FireBolt":
			queue_free()
		
func explosion():
	$AnimatedSprite2D.play("FireBoltExp")
	$ExpArea.monitoring = true
	await $AnimatedSprite2D.animation_finished
	$ExpArea.monitoring = false
	queue_free()

func _on_exp_area_body_entered(body):
	if body.is_in_group("enemies"):
		print("oi")
		body.hurtFire()
