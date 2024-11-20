extends Node2D

#@onready var cursor = $Player/Cursor
@onready var target = $Direction
@onready var porta = $door
@onready var Boss = $cavalh_skeleton

#func _ready():
	#cursor.visible = false

#func _process(delta):
	#if target and cursor.visible:
		#cursor.look_at(target.global_position)
		#cursor.rotation += deg_to_rad(90)

func _on_area_2d_2_body_entered(body):
	if body.is_in_group("player") and Boss.hp <= 0:
		TransitionManager.fade_to_scene("res://Scenes/inicio.tscn")

#func _on_cursor_timer_timeout():
	#cursor.visible = true


