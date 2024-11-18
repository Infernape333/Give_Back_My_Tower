extends Node2D

@onready var porta_aberta = $open
@onready var porta_fechada = $close
var can_open = false

func _ready():
	porta_aberta.visible = false
	porta_fechada.visible = true

func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.get_name() == "Player" or body.get_name() == "Player_arqueiro":
		porta_aberta.visible = true
		porta_fechada.visible = false

