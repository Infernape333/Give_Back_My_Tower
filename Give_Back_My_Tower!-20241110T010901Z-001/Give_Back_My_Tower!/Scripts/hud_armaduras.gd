extends Control

@onready var canvas = $".."

@onready var armadura_button = $ColorRect/TextureRect/armadura
@onready var price = $ColorRect/TextureRect/label_1
@onready var label = $ColorRect/TextureRect/box_melhorias/Label
@onready var label_coin = $ColorRect/TextureRect/box_coins/label_coins

func _ready():
	update_labels()
	VariaveisGlobais.update_health_bar()

func _process(delta):
	label_coin.text = str(floor(VariaveisGlobais.coins))

func _unhandled_input(event):
	if event.is_action_pressed("ui_up"):
		armadura_button.grab_focus()
	elif event.is_action_pressed("ui_down"):
		armadura_button.grab_focus()


func update_labels():
	label_coin.text = str(floor(VariaveisGlobais.coins))
	price.text = str(floor(VariaveisGlobais.armadura_upgrade_price))
	label.text = "Vida: " + str(VariaveisGlobais.max_life)
	# Desativar o botão se o limite de upgrades for atingido
	armadura_button.disabled = VariaveisGlobais.armadura_upgrade_count >= VariaveisGlobais.max_upgrades

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
