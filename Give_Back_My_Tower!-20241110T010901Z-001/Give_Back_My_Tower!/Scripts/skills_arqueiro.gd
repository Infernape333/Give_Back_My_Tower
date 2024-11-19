extends Area2D

var speed: float = 200
var MagicType: String = "ataque_1"
@onready var Exp_collision = $ExpDmg

var direction: Vector2 = Vector2.RIGHT:

	set(value):
		direction = value
		rotation = direction.angle()


func _physics_process(delta):
	position += speed * direction * delta
	 
func play(animation_name = "ataque_1"):
	$AnimatedSprite2D.play(animation_name)

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		if $AnimatedSprite2D.animation == "ataque_1":
			explosion()
			body.hurtFire()
		elif $AnimatedSprite2D.animation == "ataque_2":
			body.hurtIce()
			queue_free()
		elif $AnimatedSprite2D.animation == "ataque_3":
			body.hurtDark()
			queue_free()
		else:
			body.hurt()
		
		$CollisionShape2D.disabled = true
		speed = 0

func explosion():
	$AnimatedSprite2D.play("FireBoltExp")
	$CollisionShape2D.disabled = true
	await $AnimatedSprite2D.animation_finished
	queue_free()
	$CollisionShape2D.disabled = false



func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
