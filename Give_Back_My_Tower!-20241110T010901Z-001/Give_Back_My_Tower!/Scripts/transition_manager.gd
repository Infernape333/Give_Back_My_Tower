extends CanvasLayer


var new_scene:= ""

func fade_to_scene(newScene):
	VariaveisGlobais.remove_player_from_scene()
	new_scene = newScene
	$AnimationPlayer.play("fade")

func chang_scene():
	VariaveisGlobais.remove_player_from_scene()
	get_tree().change_scene_to_file(new_scene)
