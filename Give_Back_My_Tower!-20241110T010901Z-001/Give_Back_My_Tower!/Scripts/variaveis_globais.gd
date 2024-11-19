extends Node2D


#Player atual
var playerDir = "res://Scenes/player.tscn"
var has_archer = false

#armadura
var armadura_upgrade_price = 10
var max_upgrades = 80
var armadura_upgrade_count = 0

#melhoria
var attack_damage_upgrade_price = 10
var attack_speed_upgrade_price = 10
var max_upgrades_damage = 100
var max_upgrades_spd = 29
var damage_upgrade_count = 0
var speed_upgrade_count = 0


var coins = 1000
var atk_spd = 3
var dano = 5
static var danoIce = 15
static var danoFire = 25
static var danoDark = 10

var enemy_slime_damage: int = 20
var enemy_cobold_damage: int = 50
var enemy_skeleton_damage: int = 25
var enemy_Grizzly_damage: int = 100
var enemy_Gemdillo_damage: int = 40
var enemy_Orc_Rider_damage: int = 200
var BossHp = 1000
var Orc_Rider_hp = 1000
var enemy_slime_hp = 20
var enemy_cobold_hp = 100
var enemy_skeleton_hp = 50
var enemy_Grizzly_hp = 250
var enemy_Gemdillo_hp = 50

var max_life = 100
static var current_life: int = 100

func update_health_bar():
	var health_bar = get_tree().get_first_node_in_group("healthbar")
	if health_bar: 
		health_bar.max_value = VariaveisGlobais.max_life
		health_bar.value = VariaveisGlobais.current_life

func heal():
	if current_life >= max_life:
		current_life = max_life
	else:
		current_life += 10
	emit_signal("life_changed")

func game_over():
	current_life = max_life
	emit_signal("life_changed")
	get_tree().change_scene_to_file("res://Scenes/inicio.tscn")
	
func remove_enemys():
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		enemy.queue_free()
