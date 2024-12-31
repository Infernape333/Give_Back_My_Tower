extends State

class_name LeavingState

func _exit_tree():
	animation.disconnect("animation_finished", end_animation)

func enter():
	animation.play("leaving")
	animation.connect("animation_finished", end_animation)

func end_animation():
	emit_signal("Transitioned", self, "queue_free")
