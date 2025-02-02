extends Area2D

var speed: float = 100
var MagicType: String = "triptychShot"
@onready var Exp_collision = $ExpDmg

var direction: Vector2 = Vector2.RIGHT:

	set(value):
		direction = value
		rotation = direction.angle()

func _physics_process(delta):
	position += speed * direction * delta

func play(animation_name = "triptychShot"):
	$AnimatedSprite2D.play(animation_name)
	
func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.hurtFire()
		queue_free()

func explosion():
	$AnimatedSprite2D.play("FireBoltExp")
	$CollisionShape2D.disabled = true
	await $AnimatedSprite2D.animation_finished
	queue_free()
	$CollisionShape2D.disabled = false
