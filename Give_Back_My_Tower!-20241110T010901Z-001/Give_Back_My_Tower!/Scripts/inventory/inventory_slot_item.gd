class_name SlotRoot
extends PanelContainer

signal on_item_clicked(SlotRoot, bool)
signal on_item_hover(SlotRoot)

@onready var button: TextureButton = %TextureButton
@onready var label: Label = %LabelPrice
@onready var canvas_tooltip = $CanvasLayer
@onready var label_tooltip: Label = %LabelTooltip

var _item: InventoryItem
var _tooltip = ""

func _ready():
	button.tooltip_text = _tooltip
	button.pressed.connect(_on_item_clicked)
	_repositionate_tooltip_to_root()

func set_item(inventory_item: InventoryItem):
	_item = inventory_item
	
	_tooltip = _item.get_name() + ":\n"
	_tooltip += _item.get_description() + "\n\n"
	_tooltip += "Defesa: " + str(_item.get_defense()) + "\n"
	_tooltip += "Ataque: " + str(_item.get_attack())
	

func get_item() -> InventoryItem:
	return _item

func _on_item_clicked():
	on_item_clicked.emit(self)

func _repositionate_tooltip_to_root():
	remove_child(canvas_tooltip)
	get_tree().root.add_child(canvas_tooltip)
	
func _on_texture_button_mouse_entered():
	_show_tooltip()
	on_item_hover.emit(self, true)

func _on_texture_button_mouse_exited():
	_hide_tooltip()
	on_item_hover.emit(self, false)
	
func _show_tooltip():
	label_tooltip.position = get_global_mouse_position() + Vector2(40, 10)
	label_tooltip.text = _tooltip
	label_tooltip.visible = true
	label_tooltip.call_deferred("show_tooltip", _tooltip, self.get_global_transform().origin)

func _hide_tooltip():
	label_tooltip.visible = false
	
