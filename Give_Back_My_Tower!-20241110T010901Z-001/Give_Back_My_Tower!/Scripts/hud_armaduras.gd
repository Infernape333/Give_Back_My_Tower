extends Control

@onready var canvas = $".."
@onready var price = $ColorRect/TextureRect/label_1
@onready var label = $ColorRect/TextureRect/box_melhorias/Label
@onready var label_coin = $ColorRect/TextureRect/box_coins/label_coins
@onready var _grid_slots: GridContainer = $ColorRect/TextureRect/box_melhorias/GridSlots
@onready var slot_test = $ColorRect/TextureRect/box_melhorias/GridSlots/SlotTest
@onready var inventory = Inventory.new()
@onready var player: PlayerBase = VariaveisGlobais.player_instance

var slot_scene = preload("res://Scenes/inventory_slot_item.tscn")


func _ready():
	update_labels()
	_populate_inventory()
	VariaveisGlobais.update_health_bar()

func _process(delta):
	label_coin.text = str(floor(VariaveisGlobais.coins))


func update_labels():
	label_coin.text = str(floor(VariaveisGlobais.coins))

# Função para melhorar o dano de ataque
func upgrade_armadura():
	if VariaveisGlobais.coins >= VariaveisGlobais.armadura_upgrade_price and VariaveisGlobais.armadura_upgrade_count < VariaveisGlobais.max_upgrades:
		VariaveisGlobais.coins = floor(VariaveisGlobais.coins - VariaveisGlobais.armadura_upgrade_price)
		VariaveisGlobais.max_life += 5  # Incrementa o dano de ataque
		VariaveisGlobais.current_life = VariaveisGlobais.max_life
		VariaveisGlobais.armadura_upgrade_price *= 1.1  # Preço dobra a cada compra
		VariaveisGlobais.armadura_upgrade_count += 1
		
		var health_bar = get_tree().get_first_node_in_group("healthbar")
		if health_bar:
			health_bar.max_value = VariaveisGlobais.max_life
			health_bar.value = VariaveisGlobais.current_life
		update_labels()

func _on_armadura_pressed():
	upgrade_armadura()

func _on_exit_pressed():
	canvas.visible = false
	canvas.visibility_changed.connect(_on_visibility_changed)
	
func _on_visibility_changed():
	if canvas.visible:
		_refresh_slots_states()
	
func _populate_inventory():
	slot_test.visible = false
	
	for item: InventoryItem in inventory.list_of_inventory_items:
		var slot: SlotRoot = slot_scene.instantiate()
		_grid_slots.add_child(slot)
		
		var image := Image.new()
		image.load(item.get_picture())

		var texture := ImageTexture.new()
		texture.set_image(image)
		
		slot.button.texture_normal = texture
		slot.set_item(item)
		slot.label.text = str(item.get_coins())
		slot.on_item_clicked.connect(_on_inventory_item_clicked)
		_udpate_slot_state(slot)

func _refresh_slots_states():			
	var slots = _grid_slots.get_children()
	for slot in slots:
		_udpate_slot_state(slot)

func _udpate_slot_state(slot: SlotRoot):
	var inventory_item = slot.get_item()
	if inventory_item:
		if player.has_inventory_item(inventory_item):
			#_disabled_effect(slot.button)							
			slot.button.disabled = true
			slot.label.text = "Aquired"
			
			var styleBox = StyleBoxFlat.new()
			styleBox.bg_color = Color.DARK_GREEN
			slot.label.add_theme_stylebox_override("normal",styleBox )
			
		elif not player.can_buy_inventory_item(inventory_item):
			slot.button.disabled = true

func _on_inventory_item_clicked(slot: SlotRoot, inventory_item: InventoryItem):	
	_click_effect(slot.button)
	if player.can_buy_inventory_item(inventory_item):
		player.add_inventory_item(inventory_item)
		_refresh_slots_states()


func _disabled_effect(button: TextureButton):
	if button.material is ShaderMaterial:
		button.material = button.material.duplicate()
		button.material.set("shader_param/button_state", 2)
		
func _click_effect(button: TextureButton):
	if button.material is ShaderMaterial:
		button.material = button.material.duplicate()
		button.material.set("shader_param/button_state", 1)
		await get_tree().create_timer(0.2).timeout
		button.material.set("shader_param/button_state", 0)
