extends Node2D

@onready var AudioH = $Hammer
@onready var position_player = $Marker2D
@onready var HammerAudio = $Hammer

var player: PlayerBase = VariaveisGlobais.player_instance


func _enter_tree():
	if player == null:
		player = _build_global_player()
	
func _ready():
	AudioH.play()
	player.global_position = position_player.position
	add_child(player)

func _on_hammer_finished():
	AudioH.play()
	
func _build_global_player() -> PlayerBase:
	var player_scene = load(VariaveisGlobais.playerDir)
	
	if player_scene and player_scene is PackedScene:
		var player_ship = player_scene.instantiate()
		VariaveisGlobais.player_instance = player_ship
		return player_ship

	print("Erro ao carregar o personagem. Verifique o caminho em PlayerGlobal.playerDir.")
	return null
		
func _on_area_2d_body_entered(body):
		if body.get_name() == "Player" or body.get_name() == "Player_arqueiro":
			body.speed = 0
			TransitionManager.fade_to_scene("res://Scenes/floor_1.tscn")
