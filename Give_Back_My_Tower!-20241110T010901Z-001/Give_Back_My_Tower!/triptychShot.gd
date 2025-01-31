extends Skill
class_name triptychShot

func _init(target):
	cooldown = 5
	animation_name = "triptychShot"
	texture = preload("res://Sprites/skill_icons3.png")
	
	super._init(target)
	
func cast_spell(target):
	super.cast_spell(target)
	target.cone_shot()
