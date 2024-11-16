extends Skill
class_name IceSpike


func _init(target):
	cooldown = 1
	texture = preload("res://Sprites/skill_icons19.png")
	animation_name = "IceSpike"
	
	super._init(target)
	
func cast_spell(target):
	super.cast_spell(target)
	target.radial(4)
