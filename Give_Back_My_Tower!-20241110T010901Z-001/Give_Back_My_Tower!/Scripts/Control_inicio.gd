extends Control


@onready var btn1 = $start
@onready var btn2 = $quit

func _unhandled_input(event):
	if event.is_action_pressed("ui_up"):
		btn1.grab_focus()
	elif event.is_action_pressed("ui_down"):
		btn2.grab_focus()


func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/inicio.tscn")

func _on_quit_pressed():
	get_tree().quit()

