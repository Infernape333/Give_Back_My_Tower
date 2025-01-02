extends Node2D

var player_ship = "res://Scenes/player.tscn"

@onready var canvas = $CanvasLayer
var canvas_visible = false

@onready var jogador = $"../../jogador"

@onready var btn_comprar = $CanvasLayer/Control/ColorRect/TextureRect/comprar
@onready var btn_selecionar = $CanvasLayer/Control/ColorRect/TextureRect/selecionar

@onready var label_coins = $CanvasLayer/Control/ColorRect/TextureRect/box_coins/label_coins

func _ready():
	btn_selecionar.disabled = false
	btn_comprar.disabled = true
	self.visible = false

func _process(delta):
	canvas.visible = canvas_visible
	label_coins.text = str(floor(VariaveisGlobais.coins))
	
	if VariaveisGlobais.playerDir != player_ship:
		self.visible = true
		$Area2D/CollisionShape2D.disabled = false
	else:
		self.visible = false
		$Area2D/CollisionShape2D.disabled = true

func _on_area_2d_body_entered(body):
	canvas_visible = true
	
func _on_area_2d_body_exited(body):
	canvas_visible = false

func _on_selecionar_pressed():
	VariaveisGlobais.playerDir = player_ship
	jogador.on_character_selected()


func _on_comprar_pressed():
	pass


