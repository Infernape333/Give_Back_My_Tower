extends CharacterBody2D

@export var spd = 20.0
@export var hp = VariaveisGlobais.enemy_Grizzly_hp
@export var detection_range: float = 35.0

@onready var player = get_tree().get_first_node_in_group("player")
@onready var atk_collision = $Area2D/Atk

var coin_scene = preload("res://Scenes/coins.tscn") 
var potion_scene = preload("res://Scenes/porcao.tscn")
var drop_chance = 0.75
var pDrop_chance = 0.1
var atk_trigged = false
var warning_duration = 1.0
