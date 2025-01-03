extends Skill
class_name explosiveArrow

func _init(target):
	cooldown = 5
	animation_name = "explosiveArrow"
	texture = preload("res://Sprites/skill_icons56.png")
	
	super._init(target)
	
func cast_spell(target):
	super.cast_spell(target)
	target.explosive_arrow()
