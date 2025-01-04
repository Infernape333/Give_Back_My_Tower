class_name PlayerItem


# Do not change this variables directly
var _item: InventoryItem
var _amount: int

func _init(item: InventoryItem, amount: int):
	self._item = item
	self._amount = amount
