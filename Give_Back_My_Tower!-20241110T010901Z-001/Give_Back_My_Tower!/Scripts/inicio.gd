extends Node2D
@onready var AudioH = $Hammer

# Called when the node enters the scene tree for the first time.
func _ready():
	AudioH.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_hammer_finished():
	AudioH.play()
