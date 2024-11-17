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
