extends Node2D

class_name EnemySpawner

@export var tile_map: TileMap
@export var spawns: Array[Spawn_Info] = []

@onready var player = VariaveisGlobais.player_instance
@onready var player_camera = player.get_node("Camera2D")
@export var time = 0

@export var near_size: Vector2 = Vector2(80, 80)
@export var far_size: Vector2 = Vector2(200, 200)

var quad_tree: QuadTree

func _ready():
	var tile_map: TileMap = tile_map
	var tile_size: Vector2 = tile_map.tile_set.tile_size
	var used_cells_ids: Array[Vector2i] = tile_map.get_used_cells(0)
	var used_cells: Array[Rect2] = []
	
	for id in used_cells_ids:
		used_cells.append(Rect2(Vector2(id.x * tile_size.x, id.y * tile_size.y), tile_size))
	
	for spawner in spawns:
		spawner.parent = self
	
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
				var spawn_position:Vector2 = get_random_position(surrounding_cells)
				spawn_info.spawning(spawn_position, self)
				
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
	var valid_position: bool = false
	var random_key: Rect2
	
	# Only spawn if there is no StaticBody2D in the place 
	while (!valid_position):
		random_key = cells.keys().pick_random()
		var space_state: PhysicsDirectSpaceState2D = get_world_2d().direct_space_state
		var query := PhysicsPointQueryParameters2D.new()
		
		query.position = random_key.get_center()
		var results: Array[Dictionary] = space_state.intersect_point(query)
		
		var is_static_body = false
		for result in results:
			if result.collider is StaticBody2D:
				is_static_body = true
		
		if (!is_static_body):
			valid_position = true
		
		# Don't spawn two enemies in exactly the same place, they will go off the map
		cells.erase(random_key)
	
	return random_key.get_center()

