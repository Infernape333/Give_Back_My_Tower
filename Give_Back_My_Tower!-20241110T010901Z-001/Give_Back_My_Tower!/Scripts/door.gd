extends Node2D

@onready var porta_aberta = $open
@onready var porta_fechada = $close

func _ready():
	pass


func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	print("aaaaaaaaaaa")
	if body.get_name() == "Player":
		porta_aberta.visible = true
		porta_fechada.visible = false
		
		
