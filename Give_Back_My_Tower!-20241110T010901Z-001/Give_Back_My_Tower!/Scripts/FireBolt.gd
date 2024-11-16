extends Skill
class_name FireBolt
var new_audio: AudioStreamPlayer = AudioStreamPlayer.new()


func _init(target):
	cooldown = 5
	animation_name = "FireBolt"
	texture = preload("res://Sprites/skill_icons3.png")
	
	super._init(target)
	
func cast_spell(target):
	super.cast_spell(target)
	target.single_shot()
