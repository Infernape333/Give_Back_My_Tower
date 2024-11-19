extends Node2D

@onready var coins = $Control/CanvasLayer/coins

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Control/CanvasLayer/coins.text = str(VariaveisGlobais.coins)
