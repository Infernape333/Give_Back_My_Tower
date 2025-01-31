extends Area2D


var move_speed = 280
var attract_range = 75
@onready var player = get_tree().get_first_node_in_group("player")

func _ready():
	pass
	
func _process(delta):
	$Coin.play("coin")
	if player:
		var distance_to_player = position.distance_to(player.position)
		if distance_to_player <= attract_range:
			var direction = (player.position - position).normalized()
			position += direction * move_speed * delta

func _on_body_entered(body):
	if body.is_in_group("player"):
		VariaveisGlobais.coins += 1
		$AudioStreamPlayer2D.play()
		$Coin.visible = false


func _on_audio_stream_player_2d_finished():
	queue_free()
