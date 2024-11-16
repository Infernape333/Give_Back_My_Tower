extends CharacterBody2D


const SPEED = 300.0
var direction = "south"

func _physics_process(delta):
	_move()
	_update_animation()
	move_and_slide()

func _move():
	var direction : Vector2 = Vector2(Input.get_axis("walk_left", "walk_right"), Input.get_axis("walk_up", "walk_down"))
	if direction:
		velocity = direction.normalized() * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

func _update_animation():
	if velocity.length() > 0:
		if velocity.x > 0:
			$AnimatedSprite2D.play("walk")
			direction = "east"
		elif velocity.x < 0:
			$AnimatedSprite2D.play("walk")
			direction = "west"
		elif velocity.y > 0:
			$AnimatedSprite2D.play("walk")
			direction = "south"
		elif velocity.y < 0:
			$AnimatedSprite2D.play("walk")
			direction = "north"
	else:
		if direction == "east":
			$AnimatedSprite2D.play("walk")
		elif direction == "west":
			$AnimatedSprite2D.play("walk")
		elif direction == "south":
			$AnimatedSprite2D.play("walk")
		else:
			$AnimatedSprite2D.play("walk")
