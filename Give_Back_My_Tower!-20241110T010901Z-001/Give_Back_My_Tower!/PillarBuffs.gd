extends Node2D

@export var buff_attack_scene: PackedScene
var available_animations = ["Atk", "Atk_Spd", "Hp"]

@export var animation_duration: float = 1.5

var buffs: Array = []

func _ready():
	$AnimatedSprite2D.play("Pilar")
	await get_tree().create_timer(1.7).timeout
	spawn_buffs()


func spawn_buffs():
	available_animations.shuffle()
	var chosen_animations = available_animations.slice(0, 2)
	if buff_attack_scene:
		var buff_instace = buff_attack_scene.instantiate()
		buff_instace.global_position = $Marker2D.position
		var sprite = buff_instace.get_node("Sprite2D")
		if chosen_animations.size() > 0:
			var animation_name = chosen_animations[0]
			sprite.animation = animation_name
		add_child(buff_instace)

func _process(delta):
	pass
