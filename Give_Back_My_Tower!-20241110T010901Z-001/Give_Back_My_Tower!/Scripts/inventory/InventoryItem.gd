class_name InventoryItem

# Do not change this variables directly!
var _name: String
var _picture_path: String
var _coins: int = 1
var _global_amount: int = 1
var _description = ""


func _init(name: String, picture_path: String, description: String, global_amount: int, coins: int):
	self._name = name
	self._picture_path = picture_path
	self._description = description
	self._global_amount = global_amount
	self._coins = coins

func get_name() -> String:
	return self._name

func get_picture() -> String:
	return self._picture_path

func get_global_amount() -> int:
	return self._global_amount
	
func get_coins() -> int:
	return self._coins
	
func decrease(amount: int):
	self._global_amount -= amount
	


