extends Node2D


@export var type : int

@export var buff_attack_scene: PackedScene

var atks = ["Atk", "Atk_Incommun", "Atk_Rare", "Atk_Epic", "Atk_Legendary"]
var atks_spds = ["AtkSpd", "AtkSpd_Incommun", "AtkSpd_Rare", "AtkSpd_Epic", "AtkSpd_Legendary"]
var hps = ["Hp", "Hp_Incommun", "Hp_Rare", "Hp_Epic", "Hp_Legendary"]

@export var animation_duration: float = 1.5

var buffs: Array = []

var rarity_chances = {
	"Common": 0.6,       # 60%
	"Incommun": 0.2,     # 20%
	"Rare": 0.125,       # 12.5%
	"Epic": 0.05,        # 5%
	"Legendary": 0.025   # 2.5%
}

func _ready():
	$AnimatedSprite2D.play("Pilar")
	await get_tree().create_timer(1.6).timeout
	spawn_buffs()


func spawn_buffs():
	var chosen_rarity = select_rarity()
	var filtered_animations = []
	
	if type == 0:
		filtered_animations = atks.filter(func(anim_name):
			return anim_name.ends_with(chosen_rarity) or (chosen_rarity == "Common" and not anim_name.contains("_"))
			)
	elif type == 1:
		filtered_animations = atks_spds.filter(func(anim_name):
			return anim_name.ends_with(chosen_rarity) or (chosen_rarity == "Common" and not anim_name.contains("_"))
			)
	elif type == 2:
		filtered_animations = hps.filter(func(anim_name):
			return anim_name.ends_with(chosen_rarity) or (chosen_rarity == "Common" and not anim_name.contains("_"))
			)
		
	
	if filtered_animations.size() > 0:
		filtered_animations.shuffle()
		var chosen_animations = filtered_animations[0]
		print(chosen_animations)
		
		if buff_attack_scene:
			var buff_instace = buff_attack_scene.instantiate()
			buff_instace.global_position = $Marker2D.position
			var sprite = buff_instace.get_node("Sprite2D")
			sprite.animation = chosen_animations
			add_child(buff_instace)

func select_rarity() -> String:
	var random_value = randf()
	var cumulative_chance = 0.0

	for rarity in rarity_chances.keys():
		cumulative_chance += rarity_chances[rarity]
		if random_value <= cumulative_chance:
			return rarity
	return "Common" 

func _process(delta):
	if VariaveisGlobais.door_choice == 1:
		$AnimatedSprite2D.play("Down")
		await get_tree().create_timer(.7).timeout
		queue_free()



	
