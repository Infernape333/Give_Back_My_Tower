extends Timer

var cursor = null
# Called when the node enters the scene tree for the first time.
func _ready():
	cursor = get_tree().get_root().get_node("CanvasLayer/Cursor")
	if cursor:
		cursor.visible = false
	else:
		print("cursor nao encontrado")
		
	start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timeout():
	if cursor:
		cursor.visible = true
