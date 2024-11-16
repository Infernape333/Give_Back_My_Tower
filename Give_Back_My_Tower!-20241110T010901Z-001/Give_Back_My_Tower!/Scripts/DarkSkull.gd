extends Skill
class_name DarkSkull

func _init(target):
	cooldown = 7
	animation_name = "DarkSkull"
	texture = preload("res://Sprites/skill_icons29.png")
	
	super._init(target)
	
func cast_spell(target):
	super.cast_spell(target)
	target.multi_shot(4,0.2,animation_name)
