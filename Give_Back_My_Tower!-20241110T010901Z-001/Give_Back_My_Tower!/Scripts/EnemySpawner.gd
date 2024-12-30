extends Node2D

class_name EnemySpawner

@export var tile_map: TileMap
@export var spawns: Array[Spawn_Info] = []

@onready var player = get_tree().get_first_node_in_group("player")
@onready var player_camera = player.get_node("Camera2D")

@export var time = 0

@export var near_size: Vector2 = Vector2(80, 80)
@export var far_size: Vector2 = Vector2(200, 200)

var quad_tree: QuadTree
var late_spawn: Dictionary = {}

func _ready():
	var tile_map: TileMap = tile_map
	var tile_size: Vector2 = tile_map.tile_set.tile_size
	var used_cells_ids: Array[Vector2i] = tile_map.get_used_cells(0)
	var used_cells: Array[Rect2] = []
	
	for id in used_cells_ids:
		used_cells.append(Rect2(Vector2(id.x * tile_size.x, id.y * tile_size.y), tile_size))
	
	quad_tree = QuadTree.create_tree(used_cells, tile_size, 5)

func _on_timer_timeout():
	time += 1
	var enemy_spawns = spawns
	var surrounding_cells: Dictionary = get_surrounding_cells()
	
	for i in enemy_spawns:
		spawn(i, surrounding_cells)

func spawn(spawn_info: Spawn_Info, surrounding_cells: Dictionary):
	if time >= spawn_info.time_start and time <= spawn_info.time_end:
		if spawn_info.spawn_delay_counter < spawn_info.enemy_spawn_delay:
			spawn_info.spawn_delay_counter += 1
		else:
			spawn_info.spawn_delay_counter = 0
			var animation: Resource = spawn_info.spawn_animation
			var counter = 0
			
			while  counter < spawn_info.enemy_num:
				var animation_spawn: Node2D = animation.instantiate()
				
				animation_spawn.global_position = get_random_position(surrounding_cells)
				animation_spawn.z_index = global_position.y
				late_spawn[animation_spawn] = spawn_info
				animation_spawn.connect("Transitioned", on_state_machine_transition)
				call_deferred("add_child", animation_spawn)
				
				counter += 1

func get_surrounding_cells() -> Dictionary:
	var player_position: Vector2 = player.global_position
	var area_near: Rect2 = Rect2(player_position - (near_size / 2.0), near_size)
	var area_far: Rect2 = Rect2(player_position - (far_size / 2.0), far_size)
	var surrounding_cells_far: Dictionary = quad_tree.get_surrounding_cells(area_far)
	var surrounding_cells_near: Dictionary = quad_tree.get_surrounding_cells(area_near)
	
	for key in surrounding_cells_near.keys():
		surrounding_cells_far.erase(key)
	
	return surrounding_cells_far

func get_random_position(cells: Dictionary) -> Vector2:
	var random_key: Rect2 = cells.keys().pick_random()
	
	# Don't spawn two enemies in exactly the same place, they will go off the map
	cells.erase(random_key)
	
	return random_key.get_center()

func on_state_machine_transition (state_machine: StateMachine, new_state_name: String):
	if (new_state_name == "LEAVING"):
		var new_enemy = late_spawn[state_machine].enemy
		var enemy_spawn = new_enemy.instantiate()
		
		enemy_spawn.global_position = state_machine.global_position
		
		call_deferred("add_child", enemy_spawn)
		state_machine.disconnect("Transitioned", on_state_machine_transition)
