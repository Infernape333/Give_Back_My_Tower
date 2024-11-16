extends Area2D

var is_working = false

func _ready():
	$BlacksmithS.play("Idle")
	$ChangeType.start(4)

func _on_change_type_timeout():
	$ChangeType.stop()
	is_working = true
	$BlacksmithS.play("Working")
	
	await get_tree().create_timer(5).timeout
	is_working = false
	$BlacksmithS.play("Idle")
	$ChangeType.start()
	

func _input(event):
	if event.is_action_pressed("Interaction") and len(get_overlapping_bodies()) > 0:
		use_dialogue()
		
func use_dialogue():
	var dialogue = get_node("DialogueBox")
	
	if dialogue:
		dialogue.start()
