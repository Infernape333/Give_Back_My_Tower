class_name PlayerBase
extends CharacterBody2D

const MAX_LIFE = 100
const _INITIAL_ATTACK = 5
const _INITIAL_DEFENSE = 0
const _DEFAULT_HEAL = 10
const _INITIAL_COINS = 5

# Do not change this variables directly
var _attack = _INITIAL_ATTACK
var _defense = _INITIAL_DEFENSE
var _current_life: int = MAX_LIFE
var _curr_coins: int = _INITIAL_COINS
var _inventory_items : Array[InventoryItem] = []

func add_inventory_item(item: InventoryItem):
	if _is_item_already_added(item): return	
	_attack += item.get_attack()
	_defense += item.get_defense()
	_curr_coins -= item.get_coins()
	_inventory_items.push_back(item)

func set_life_damage(damage: int):
	var total = _current_life + _defense - damage
	total = max(total, 0)
	_current_life = min(total, MAX_LIFE)
	
func heal(amount: int = _DEFAULT_HEAL):
	_current_life = min(_current_life + amount, MAX_LIFE)
	
func has_inventory_item(item: InventoryItem):
	return _is_item_already_added(item)
	
func get_coins() -> int:
	return _curr_coins

func set_coins(amount: int):
	_curr_coins = amount
	
func can_buy_inventory_item(item: InventoryItem) -> bool:
	if get_coins() >= item.get_coins():
		return true
	return false
	
func reset_states():
	_current_life = MAX_LIFE
	_attack = _INITIAL_ATTACK
	_defense = _INITIAL_DEFENSE
	_inventory_items.clear()
	
func get_attack(): 
	return _attack

func get_defense():
	return _defense
	
func get_curr_life():
	return min(_current_life, MAX_LIFE)

func _is_item_already_added(item: InventoryItem):
	for i in _inventory_items:
		if i.get_id() == item.get_id():
			return true
	return false
	
