extends Area2D

var speed: float = 200
var MagicType: String = "triptychShot"
@onready var Exp_collision = $ExpDmg

var direction: Vector2 = Vector2.RIGHT:

	set(value):
		direction = value
		rotation = direction.angle()

var inimigos_na_area: Array = []

func _physics_process(delta):
	position += speed * direction * delta
	
	for inimigo in inimigos_na_area:
		#if inimigo.is_valid():  # Verifica se o inimigo ainda existe
			inimigo.hurtFire()
	 
func play(animation_name = "triptychShot"):
	$AnimatedSprite2D.play(animation_name)
	
func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		if $AnimatedSprite2D.animation == "triptychShot":
			body.hurtFire()
			queue_free()
		elif $AnimatedSprite2D.animation == "explosiveArrow":
			explosion()
			body.hurtIce()
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

func _on_area_2d_body_entered(body):
	if body.is_in_group("enemies"):
		inimigos_na_area.append(body)


func _on_area_2d_body_exited(body):
	if body.is_in_group("enemies"):
		inimigos_na_area.erase(body)

func habilitar_colisao():
	$area_attack_03/Area2D/Collision_attack_03.disabled = false
	$CollisionShape2D.disabled = true

func destroir():
	$area_attack_03/Area2D/Collision_attack_03.disabled = true
	$CollisionShape2D.disabled = false
	#queue_free()
