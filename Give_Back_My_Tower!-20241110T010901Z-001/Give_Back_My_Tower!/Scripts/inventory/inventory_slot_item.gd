class_name SlotRoot
extends PanelContainer

signal on_item_clicked(SlotRoot, InventoryItem)

@onready var button: TextureButton = %TextureButton
@onready var label: Label = %LabelPrice

var _item: InventoryItem
var _tooltip = ""

func _ready():
	button.tooltip_text = _tooltip
	button.pressed.connect(_on_item_clicked)

func set_item(inventory_item: InventoryItem):
	_item = inventory_item
	
	_tooltip = _item.get_name() + ":\n"
	_tooltip += _item.get_description() + "\n\n"
	_tooltip += "Defesa: " + str(_item.get_defense()) + "\n"
	_tooltip += "Ataque: " + str(_item.get_attack())
	

func get_item() -> InventoryItem:
	return _item

func _on_item_clicked():
	on_item_clicked.emit(self, _item)
