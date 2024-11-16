extends Sprite2D

var target = null
# Called when the node enters the scene tree for the first time.
func _ready():
	target = get_tree().get_root().get_node("Direction")
	if not target:
		print("nao encotnrado")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func direction():
	if target:
		look_at(target.global_position)

func _on_cursor_timer_timeout():
	direction()
