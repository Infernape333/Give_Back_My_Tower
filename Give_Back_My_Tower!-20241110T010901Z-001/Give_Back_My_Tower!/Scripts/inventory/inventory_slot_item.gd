class_name SlotRoot
extends PanelContainer


signal on_mouse_hover(InventoryItem, bool)
signal on_item_clicked(InventoryItem)

var _item: InventoryItem


func set_item(inventory_item: InventoryItem):
	self._item = inventory_item

func get_item() -> InventoryItem:
	return self._item
	
func _on_texture_button_mouse_entered():
	on_mouse_hover.emit(self._item, true)

func _on_texture_button_mouse_exited():
	on_mouse_hover.emit(self._item, false)

func _on_texture_button_pressed():
	on_item_clicked.emit(self._item)
