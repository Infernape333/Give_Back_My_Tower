extends Node2D

var player_ship = "res://Scenes/player.tscn"

@onready var canvas = $CanvasLayer
var canvas_visible = false

@onready var jogador = $"../../jogador"

@onready var btn_comprar = $CanvasLayer/Control/ColorRect/TextureRect/comprar
@onready var btn_selecionar = $CanvasLayer/Control/ColorRect/TextureRect/selecionar

func _ready():
	btn_selecionar.disabled = false
	btn_comprar.disabled = true

func _process(delta):
	canvas.visible = canvas_visible
	
	if VariaveisGlobais.playerDir == player_ship:
		self.visible = false
		$Area2D/CollisionShape2D.disabled = true
	else:
		self.visible = true
		$Area2D/CollisionShape2D.disabled = false

func _on_area_2d_body_entered(body):
	canvas_visible = true
	
func _on_area_2d_body_exited(body):
	canvas_visible = false

func _on_selecionar_pressed():
	VariaveisGlobais.playerDir = player_ship
	jogador.on_character_selected()


func _on_comprar_pressed():
	pass
