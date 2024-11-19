extends Node2D


#@onready var cursor = $Player/Cursor
@onready var target = $Direction
@onready var porta = $door

#func _ready():
	#cursor.visible = false

#func _process(delta):
	#if target and cursor.visible:
		#cursor.look_at(target.global_position)
		#cursor.rotation += deg_to_rad(90)

func _on_area_2d_2_body_entered(body):
	TransitionManager.fade_to_scene("res://Scenes/floor_5.tscn")


func _on_timer_timeout():
	VariaveisGlobais.remove_enemys()
	$Area2D2/CollisionShape2D.disabled = false
	porta.can_open = true

#func _on_cursor_timer_timeout():
	#cursor.visible = true
