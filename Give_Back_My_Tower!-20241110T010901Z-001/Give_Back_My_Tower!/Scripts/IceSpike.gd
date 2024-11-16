extends Skill
class_name IceSpikes
var is_in_initial_scene: bool = false

func _init(target):
	cooldown = 10
	texture = preload("res://Sprites/skill_icons19.png")
	animation_name = "IceSpikes"
	
	super._init(target)
	
func cast_spell(target):
	if is_in_initial_scene:
		return
	super.cast_spell(target)
	target.radial(4)
