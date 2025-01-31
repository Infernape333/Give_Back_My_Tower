extends Area2D

@export var text_key: String = ""
var play_in_area: bool = false
var dialogo_em_andamento: bool = false

func _ready():
	$AnimatedSprite2D.play("idle")

func _process(delta):
	pass


func _input(event):
	if play_in_area and Input.is_action_just_pressed("Interaction") and not dialogo_em_andamento:
		Singlebus.emit_signal("display_dialog", text_key)
		print("s")
	
func _on_body_entered(body):
	if body.get_name() == "Player" or body.get_name() == "Player_arqueiro":
		play_in_area = true

func _on_body_exited(body):
	if body.get_name() == "Player" or body.get_name() == "Player_arqueiro":
		play_in_area = false
