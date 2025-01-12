extends CanvasLayer


var new_scene:= ""

func fade_to_scene(newScene):
	_remove_player_from_scene()
	new_scene = newScene
	$AnimationPlayer.play("fade")

func chang_scene():
	_remove_player_from_scene()
	get_tree().change_scene_to_file(new_scene)

"""
This method prevents global player_instance to be cleared from memory 
when changing scenes.
"""
func _remove_player_from_scene(): 
	var player: PlayerBase = VariaveisGlobais.player_instance
	if player != null and player.get_parent() != null:
		player.get_parent().remove_child(player)
