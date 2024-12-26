extends Node2D

var choice = 0
var PillarBuffs = preload("res://Scenes/pillar_buffs.tscn")
@onready var cursor = $jogador/Cursor
@onready var target = $Direction
@onready var porta = $door
@onready var Buff1 = $Marker2D



func _ready():
	if choice == 1:
		porta.can_open = true

func _process(delta):
	if target and cursor.visible:
		cursor.look_at(target.global_position)
		cursor.rotation += deg_to_rad(90)

func _on_timer_timeout():
	#VariaveisGlobais.remove_enemys()
	$Door/CollisionShape2D.disabled = false
	Spawn_Buff1()

func Spawn_Buff1():
	var buff_instantiate = PillarBuffs.instantiate()
	buff_instantiate.global_position = Buff1.global_position
	add_child(buff_instantiate)
	
func _on_cursor_timer_timeout():
	cursor.visible = true
	
func _on_area_2d_body_entered(body):
	TransitionManager.fade_to_scene("res://Scenes/floor_2.tscn")

