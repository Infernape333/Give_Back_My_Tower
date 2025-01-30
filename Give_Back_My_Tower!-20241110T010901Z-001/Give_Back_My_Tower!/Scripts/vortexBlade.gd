extends Skill
class_name vortexBlade

func _init(target):
	cooldown = 5
	animation_name = "vortexBlade"
	texture = preload("res://Sprites/skill_icons55.png")
	
	super._init(target)
	
func cast_spell(target):
	super.cast_spell(target)
	target.vortex_blade()
