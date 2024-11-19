extends Control
@onready var audio = $"../AudioStreamPlayer"

# Called when the node enters the scene tree for the first time.
func _ready():
	audio.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_pressed():
	TransitionManager.fade_to_scene("res://Scenes/inicio.tscn")

func _on_quit_pressed():
	get_tree().quit()


func _on_audio_stream_player_finished():
	audio.play()
