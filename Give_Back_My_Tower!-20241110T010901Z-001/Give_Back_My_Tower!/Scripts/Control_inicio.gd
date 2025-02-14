extends Control


@onready var audio = $"../AudioStreamPlayer"

var mouse_sensitivity := 45.0
var x_axis
var y_axis
var deadzone := 1.0

func _ready():
	audio.play()
	$AnimatedSprite2D.play("default")

func _process(delta):
# Aplica zona morta para evitar drift no analógico
	var move_x = 0.0 if abs(x_axis) < deadzone else x_axis
	var move_y = 0.0 if abs(y_axis) < deadzone else y_axis

	# Se houver movimento, atualiza a posição do mouse
	if move_x != 0.0 or move_y != 0.0:
		var mouse_pos = get_viewport().get_mouse_position()
		var new_mouse_pos = mouse_pos + Vector2(move_x, move_y) * mouse_sensitivity * delta * 60  # Fator de ajuste
		Input.warp_mouse(new_mouse_pos)


func _input(event):
	if Input.is_action_just_pressed("Enter"):
		TransitionManager.fade_to_scene("res://Scenes/inicio.tscn")
	if event is InputEventJoypadMotion:
		if event.axis == 2:  # Analógico direito - eixo X
			x_axis = event.axis_value
		elif event.axis == 3:  # Analógico direito - eixo Y
			y_axis = event.axis_value

func _on_start_pressed():
	TransitionManager.fade_to_scene("res://Scenes/inicio.tscn")

func _on_quit_pressed():
	get_tree().quit()


func _on_audio_stream_player_finished():
	audio.play()
