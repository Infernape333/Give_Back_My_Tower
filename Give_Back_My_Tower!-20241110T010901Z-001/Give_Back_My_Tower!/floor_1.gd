extends Node2D

var choice = 0
var PillarBuffs = preload("res://Scenes/pillar_buffs.tscn")
@onready var jogador_node = $jogador
@onready var target = $Direction
@onready var porta = $door
@onready var Buff1 = $Marker2D

var Player
var Cursor = preload("res://Scenes/cursor.tscn")
var cursor_instance = null 

func _ready():
	if choice == 1:
		porta.can_open = true
	
	Player = jogador_node.get_tree().get_nodes_in_group("player")
	

func _process(delta):
	if target and cursor_instance and cursor_instance.visible:
		cursor_instance.look_at(target.global_position)
		cursor_instance.rotation += deg_to_rad(90)

func _on_timer_timeout():
	#VariaveisGlobais.remove_enemys()
	$Door/CollisionShape2D.disabled = false
	Spawn_Buff1()

func Spawn_Buff1():
	var buff_instantiate = PillarBuffs.instantiate()
	buff_instantiate.global_position = Buff1.global_position
	add_child(buff_instantiate)
	
func _on_cursor_timer_timeout():
	if not cursor_instance:
		cursor_instance = Cursor.instantiate()
	if Player and Player.size() > 0:
		cursor_instance.position =  Vector2(0, -15)
		Player[0].add_child(cursor_instance)
	else:
		print("Erro: Nenhum jogador encontrado no grupo 'player'.")

func _on_area_2d_body_entered(body):
	TransitionManager.fade_to_scene("res://Scenes/floor_2.tscn")

