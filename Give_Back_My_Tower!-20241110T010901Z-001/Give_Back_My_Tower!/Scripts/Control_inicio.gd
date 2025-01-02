extends Control


@onready var audio = $"../AudioStreamPlayer"

func _ready():
	audio.play()
	$AnimatedSprite2D.play("default")


func _process(delta):
	pass

func _input(event):
	if Input.is_action_just_pressed("Enter"):
		TransitionManager.fade_to_scene("res://Scenes/inicio.tscn")

func _on_start_pressed():
	TransitionManager.fade_to_scene("res://Scenes/inicio.tscn")

func _on_quit_pressed():
	get_tree().quit()


func _on_audio_stream_player_finished():
	audio.play()
