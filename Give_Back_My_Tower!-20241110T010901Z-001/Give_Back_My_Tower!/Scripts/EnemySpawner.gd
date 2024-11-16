extends Node2D

@export var spawns: Array[Spawn_Info] = []

@onready var player = get_tree().get_first_node_in_group("player")
@onready var player_camera = player.get_node("Camera2D")

@export var time = 0


func _on_timer_timeout():
	time += 1
	var enemy_spawns = spawns
	for i in enemy_spawns:
		if time >= i.time_start and time <= i.time_end:
			if i.spawn_delay_counter < i.enemy_spawn_delay:
				i.spawn_delay_counter += 1
			else:
				i.spawn_delay_counter = 0
				var new_enemy = i.enemy
				var counter = 0
				while  counter < i.enemy_num:
					var enemy_spawn = new_enemy.instantiate()
					enemy_spawn.global_position = get_random_position()
					add_child(enemy_spawn)
					counter += 1

func get_random_position():
	var camera_size = get_viewport_rect().size / player_camera.zoom
	var margin = 100
	var top_left = Vector2(player.global_position.x - camera_size.x/2 - margin, player.global_position.y - camera_size.y/2 - margin)
	var top_right = Vector2(player.global_position.x + camera_size.x/2 + margin, player.global_position.y - camera_size.y/2 - margin)
	var bottom_left = Vector2(player.global_position.x - camera_size.x/2 - margin, player.global_position.y + camera_size.y/2 + margin)
	var bottom_right = Vector2(player.global_position.x + camera_size.x/2 + margin, player.global_position.y + camera_size.y/2 + margin)
	var pos_side = ["up","down","right","left"].pick_random()
	var spawn_pos1 = Vector2.ZERO
	var spawn_pos2 = Vector2.ZERO
	
	match pos_side:
		"up":
			spawn_pos1 = top_left
			spawn_pos2 = top_right
		"down":
			spawn_pos1 = bottom_left
			spawn_pos2 = bottom_right
		"right":
			spawn_pos1 = top_right
			spawn_pos2 = bottom_right
		"left":
			spawn_pos1 = top_left
			spawn_pos2 = bottom_left
	
	var x_spawn = randf_range(spawn_pos1.x, spawn_pos2.x)
	var y_spawn = randf_range(spawn_pos1.y,spawn_pos2.y)
	return Vector2(x_spawn,y_spawn)
	
	
	
