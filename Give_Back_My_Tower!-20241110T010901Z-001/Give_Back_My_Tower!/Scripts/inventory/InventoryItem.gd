class_name InventoryItem

# Do not change this variables directly!
var _name: String
var _picture_path: String
var _defense: int
var _attack: int
var _coins: int = 1
var _global_amount: int = 1
var _description = ""


<<<<<<< HEAD
func _init(name: String, picture_path: String, description: String, defense: int, attack: int, global_amount: int, coins: int):
	self._name = name
	self._picture_path = picture_path
	self._description = description
	self._defense = defense
	self._attack = attack
	self._global_amount = global_amount
	self._coins = coins

func get_name() -> String:
	return self._name
=======
func _init(id: int, name: String, picture_path: String, description: String, defense: int, attack: int, global_amount: int, coins: int):
	_id = id
	_name = name
	_picture_path = picture_path
	_description = description
	_defense = defense
	_attack = attack
	_global_amount = global_amount
	_coins = coins

func get_id() -> int: return _id
	
func get_name() -> String: return _name
>>>>>>> e30bd13 (Removing self keyord from uncessary code)
	
func get_description() -> String: return _description

func get_picture() -> String: return _picture_path

func get_global_amount() -> int: return _global_amount
	
func get_defense() -> int: return _defense

func get_attack() -> int: return _attack
	
func get_coins() -> int: return _coins
	
func decrease(amount: int):
	_global_amount -= amount
	


