extends Control


@onready var damage_button = $TextureRect/dano_ataque
@onready var speed_button = $TextureRect/ataque_velocidade
@onready var price1 = $TextureRect/price1
@onready var price2 = $TextureRect/price2
@onready var label = $TextureRect/melhorias

func _ready():
	$TextureRect/AnimatedSprite2D.play("encantamentos")
	update_labels()

func _unhandled_input(event):
	if event.is_action_pressed("ui_up"):
		damage_button.grab_focus()
	elif event.is_action_pressed("ui_down"):
		speed_button.grab_focus()

func update_labels():
	price1.text = "R$: " + str(floor(VariaveisGlobais.attack_damage_upgrade_price))
	price2.text = "R$: " + str(floor(VariaveisGlobais.attack_speed_upgrade_price))
	label.text = "Dano de ataque: " + str(VariaveisGlobais.dano) + "\n" + "Velocidade de ataque: " + str(VariaveisGlobais.atk_spd)
	# Desativar o botão se o limite de upgrades for atingido
	damage_button.disabled = VariaveisGlobais.damage_upgrade_count >= VariaveisGlobais.max_upgrades_damage
	speed_button.disabled = VariaveisGlobais.speed_upgrade_count >= VariaveisGlobais.max_upgrades_spd

# Função para melhorar o dano de ataque
func upgrade_attack_damage():
	if VariaveisGlobais.coins >= VariaveisGlobais.attack_damage_upgrade_price and VariaveisGlobais.damage_upgrade_count < VariaveisGlobais.max_upgrades_damage:
		VariaveisGlobais.coins = floor(VariaveisGlobais.coins - VariaveisGlobais.attack_damage_upgrade_price)
		VariaveisGlobais.dano += 2.5  # Incrementa o dano de ataque
		VariaveisGlobais.attack_damage_upgrade_price *= 1.1  # Preço dobra a cada compra
		VariaveisGlobais.damage_upgrade_count += 1
		update_labels()

# Função para melhorar a velocidade de ataque
func upgrade_attack_speed():
	if VariaveisGlobais.coins >= VariaveisGlobais.attack_speed_upgrade_price and VariaveisGlobais.speed_upgrade_count < VariaveisGlobais.max_upgrades_spd:
		VariaveisGlobais.coins = floor(VariaveisGlobais.coins - VariaveisGlobais.attack_speed_upgrade_price)
		VariaveisGlobais.atk_spd -= 0.10  # Incrementa a velocidade de ataque
		VariaveisGlobais.attack_speed_upgrade_price *= 1.1  # Preço dobra a cada compra
		VariaveisGlobais.speed_upgrade_count += 1
		update_labels()

func _on_ataque_velocidade_pressed():
	upgrade_attack_speed()

func _on_dano_ataque_pressed():
	upgrade_attack_damage()
