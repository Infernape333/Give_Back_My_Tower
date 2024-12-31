extends State

class_name StandingState

@export var time_to_stand: float = 1.0

func enter():
	animation.play("standing")
	await get_tree().create_timer(time_to_stand).timeout
	
	emit_signal("Transitioned", self, "LEAVING")
