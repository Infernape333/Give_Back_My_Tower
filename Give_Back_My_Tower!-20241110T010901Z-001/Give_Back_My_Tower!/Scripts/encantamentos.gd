extends Area2D


@onready var melhorias = $hud_melhorias
@onready var key_e = $KeyE

var play_in_area = false

func _ready():
	$AnimatedSprite2D.play("default")

func _on_body_entered(body):
	if body.get_name() == "Player":
		play_in_area = true
		key_e.visible = true

func _input(event):
	if play_in_area and event.is_action_pressed("Interaction"):
		melhorias.visible = true


func _on_body_exited(body):
	if body.get_name() == "Player":
		play_in_area = false
		melhorias.visible = false
		key_e.visible = false
