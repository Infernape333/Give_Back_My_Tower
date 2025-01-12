extends Node
class_name Inventory

var list_of_inventory_items: Array[InventoryItem] = []

func _init():
	var file = FileAccess.get_file_as_string("res://Scripts/inventory/inventory_data.json")
	var data = JSON.parse_string(file)
	var item_id = 0
	
	for item in data:
		var inventory_item = InventoryItem.new(item_id, item.name, item.picture_path, item.description, item.defense, item.attack, item.global_amount, item.coins)
		list_of_inventory_items.push_back(inventory_item)
		item_id += 1
