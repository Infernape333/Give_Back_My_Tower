extends CanvasLayer

@onready var voltar = $Control/voltar
@onready var sair = $Control/sair

func _ready():
	self.visible = false

func _unhandled_input(event):
	if event.is_action("ui_cancel"):
		self.visible = true
		get_tree().paused = true

func _on_voltar_pressed():
	get_tree().paused = false
	self.visible = false
