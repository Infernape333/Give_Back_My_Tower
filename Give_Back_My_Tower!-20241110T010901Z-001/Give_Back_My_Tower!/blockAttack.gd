extends Skill
class_name blockAttack

func _init(target):
	cooldown = 5
	animation_name = "blockAttack"
	texture = preload("res://Sprites/skill_icons55.png")
	
	super._init(target)
	
func cast_spell(target):
	super.cast_spell(target)
	target.block_attack()
