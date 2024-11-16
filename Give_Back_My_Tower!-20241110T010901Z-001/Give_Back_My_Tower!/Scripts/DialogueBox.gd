extends CanvasLayer

@export_file("*.json") var d_file

@export var player: CharacterBody2D
var dialogue = []
var current_dialogue = 0
var d_active = false

func _ready():
	$NinePatchRect.visible = false
	
func start():
	if d_active:
		return
	d_active = true
	$NinePatchRect.visible = true
	dialogue = load_dialogue()
	current_dialogue = -1
	next_script()
	
	$NinePatchRect/Name.text = dialogue[0]["name"]
	$NinePatchRect/Text.text = dialogue[0]["text"]
	
	if player:
		player.set_dialogue_active(true)
	
func load_dialogue():
	var file = FileAccess.open("res://Assets/Dialogo1.json", FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	return content
	
func _input(event):
	if not d_active:
		return
	if event.is_action_pressed("Interaction"):
		next_script()

func next_script():
	current_dialogue += 1
	if current_dialogue >= len(dialogue):
		$Timer.start()
		$NinePatchRect.visible = false
		return
	$NinePatchRect/Name.text = dialogue[current_dialogue]["name"]
	$NinePatchRect/Text.text = dialogue[current_dialogue]["text"]
	

func _on_timer_timeout():
	d_active = false
	if player:
		player.set_dialogue_active(false)
