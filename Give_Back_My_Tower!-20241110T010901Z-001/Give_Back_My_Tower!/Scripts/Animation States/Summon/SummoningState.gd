extends State

class_name SummoningState

func _exit_tree():
	animation.disconnect("animation_finished", end_animation)

func enter():
	animation.play("summoning")
	animation.connect("animation_finished", end_animation)

func end_animation():
	emit_signal("Transitioned", self, "STANDING")
