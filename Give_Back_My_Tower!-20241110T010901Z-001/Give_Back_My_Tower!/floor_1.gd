extends Node2D

var choice = 0
var PillarBuffs = preload("res://Scenes/pillar_buffs.tscn")
@onready var cursor = $jogador/Cursor
@onready var target = $Direction
@onready var porta = $door
@onready var Buff1 = $Marker2D
@onready var Buff2 = $Marker2D2
@onready var Buff3 = $Marker2D3
@onready var marker_player = %MarkerPlayer
@onready var player: PlayerBase = VariaveisGlobais.player_instance

var buff_spawned = false 


func _ready():
	player.global_position = marker_player.position
	add_child(player)

func _process(delta):
	if VariaveisGlobais.door_choice == 1:
		porta.can_open = true
		$Door/CollisionShape2D.disabled = false

func _on_timer_timeout():
	Spawn_Buff1()

func Spawn_Buff1():
	if not buff_spawned:  
		var buff_instantiate = PillarBuffs.instantiate()
		var buff_instantiate2 = PillarBuffs.instantiate()
		var buff_instantiate3 = PillarBuffs.instantiate()
		buff_instantiate.global_position = Buff1.global_position
		buff_instantiate2.global_position = Buff2.global_position
		buff_instantiate3.global_position = Buff3.global_position
		buff_instantiate.type = 0
		add_child(buff_instantiate)
		buff_instantiate2.type = 1
		add_child(buff_instantiate2)
		buff_instantiate3.type = 2
		add_child(buff_instantiate3)
		buff_spawned = true  # Atualiza o flag para evitar novos spawns
#func _on_cursor_timer_timeout():
	#cursor.visible = true
	
func _on_area_2d_body_entered(body):
	VariaveisGlobais.door_choice -= 1
	TransitionManager.fade_to_scene("res://Scenes/floor_2.tscn")

