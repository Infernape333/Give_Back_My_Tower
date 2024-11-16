extends Area2D


var move_speed = 280
var attract_range = 75
@onready var player = get_tree().get_first_node_in_group("player")

func _ready():
	pass
	
func _process(delta):
	$AnimatedSprite2D.play("porcao")
	if player:
		var distance_to_player = position.distance_to(player.position)
		if distance_to_player <= attract_range:
			var direction = (player.position - position).normalized()
			position += direction * move_speed * delta

func _on_body_entered(body):
	if body.get_name() == "Player":
		body.heal(10)
		$AudioStreamPlayer2D.play()
		$AnimatedSprite2D.visible = false


func _on_audio_stream_player_2d_finished():
	queue_free()


