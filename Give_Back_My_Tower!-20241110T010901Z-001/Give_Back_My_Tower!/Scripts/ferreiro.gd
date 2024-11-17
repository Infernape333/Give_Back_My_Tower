extends Area2D


@onready var armaduras = $hud_armaduras
@onready var key_e = $KeyE

var is_working = false
var play_in_area = false

func _ready():
	$BlacksmithS.play("Working")

func _on_body_entered(body):
	if body.get_name() == "Player":
		play_in_area = true
		key_e.visible = true

func _input(event):
	if play_in_area and event.is_action_pressed("Interaction"):
		armaduras.visible = true


func _on_body_exited(body):
	if body.get_name() == "Player":
		play_in_area = false
		armaduras.visible = false
		key_e.visible = false


func _on_change_type_timeout():
	is_working = true
	await get_tree().create_timer(4).timeout
	is_working = false
