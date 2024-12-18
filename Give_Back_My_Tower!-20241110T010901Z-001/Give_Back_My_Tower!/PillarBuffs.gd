extends Node2D

@export var buff_attack_scene: PackedScene
@export var buff_hp_scene: PackedScene
@export var buff_attack_speed_scene: PackedScene

@export var animation_duration: float = 1.5

var buffs: Array = []

func _ready():
	$AnimatedSprite2D.play("Pilar")
	buffs = [
		{ "type": "attack", "scene": buff_attack_scene },
		{ "type": "hp", "scene": buff_hp_scene },
		{ "type": "attack_speed", "scene": buff_attack_speed_scene }
	]
	start_process()


func start_process():
	get_tree().create_timer(animation_duration).timeout
	spawn_buffs()

func spawn_buffs():
	var chosen_buffs = buffs.slice(0, 1)
	
	for buff in chosen_buffs:
		var buff_instance = buff.scene.instantiate()
		buff_instance.global_position = global_position + Vector2(0, -50)
		add_child(buff_instance)
		
		apply_buff(buff.type)


func apply_buff(buff_type: String):
	match buff_type:
		"Attack":
			VariaveisGlobais.dano += 2.5
		"Hp":
			VariaveisGlobais.max_life += 5
		"attack_speed":
			VariaveisGlobais.atk_spd -= .2
func _process(delta):
	pass
