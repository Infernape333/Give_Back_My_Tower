extends Node2D

var choice = 0
var PillarBuffs = preload("res://Scenes/pillar_buffs.tscn")
#@onready var cursor = $Cursor
@onready var target = $Direction
@onready var porta = $door
@onready var Buff1 = $Marker2D
@onready var Buff2 = $Marker2D2
var buff_spawned = false 


func _ready():
	pass

func _process(delta):
	if VariaveisGlobais.door_choice == 1:
		porta.can_open = true
		$Area2D/CollisionShape2D.disabled = false

func _on_timer_timeout():
	#VariaveisGlobais.remove_enemys()
	Spawn_Buff1()

func Spawn_Buff1():
	if not buff_spawned:  
		var buff_instantiate = PillarBuffs.instantiate()
		var buff_instantiate2 = PillarBuffs.instantiate()
		buff_instantiate.global_position = Buff1.global_position
		buff_instantiate2.global_position = Buff2.global_position
		add_child(buff_instantiate)
		add_child(buff_instantiate2)
		buff_spawned = true  
#func _on_cursor_timer_timeout():
	#cursor.visible = true

func _on_area_2d_body_entered(body):
	TransitionManager.fade_to_scene("res://Scenes/floor_3.tscn")
