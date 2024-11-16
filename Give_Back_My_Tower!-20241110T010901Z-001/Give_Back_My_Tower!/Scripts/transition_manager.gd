extends CanvasLayer


var new_scene:= ""

func fade_to_scene(newScene):
	new_scene = newScene
	$AnimationPlayer.play("fade")

func chang_scene():
	get_tree().change_scene_to_file(new_scene)
