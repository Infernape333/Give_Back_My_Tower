extends Skill
class_name hailArrows

func _init(target):
	cooldown = 5
	animation_name = "hailArrows"
	texture = preload("res://Sprites/skill_icons29.png")
	
	super._init(target)
	
func cast_spell(target):
	super.cast_spell(target)
	target.hail_arrows()
