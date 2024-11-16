extends Node2D

@onready var coins = $Control/CanvasLayer/coins
# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/CanvasLayer/Sprite2D.play("coin")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Control/CanvasLayer/coins.text = str(VariaveisGlobais.coins)
