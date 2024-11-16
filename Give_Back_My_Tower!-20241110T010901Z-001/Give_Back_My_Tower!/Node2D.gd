extends Node2D

@onready var sprite = $CanvasLayer/Sprite2D
@onready var target = $CanvasLayer/Direction 

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target:
		sprite.look_at(target.global_position)
