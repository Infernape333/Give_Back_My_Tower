extends Skill
class_name flamingBlade

func _init(target):
	cooldown = 5
	animation_name = "flamingBlade"
	texture = preload("res://Sprites/skill_icons56.png")
	
	super._init(target)
	
func cast_spell(target):
	super.cast_spell(target)
	target.flaming_blade()
