extends Node2D

@onready var position_player = $Marker2D
var player_ship = null

func _ready():
	load_player()

func load_player():
	if player_ship:
		player_ship.queue_free()
	
	var player_scene = load(VariaveisGlobais.playerDir)
	
	if player_scene and player_scene is PackedScene:
		player_ship = player_scene.instantiate()
		player_ship.global_position = position_player.position
		add_child(player_ship)
	else:
		print("Erro ao carregar o personagem. Verifique o caminho em PlayerGlobal.playerDir.")

func on_character_selected():
	load_player()


func _on_area_2d_body_entered(body):
		if body.get_name() == "Player" or body.get_name() == "Player_arqueiro":
			body.speed = 0
			TransitionManager.fade_to_scene("res://Scenes/floor_1.tscn")
