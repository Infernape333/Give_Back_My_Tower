extends Resource

class_name Spawn_Info

@export var time_start:int
@export var time_end:int
@export var spawn_animation: Resource
@export var enemy:Resource
@export var enemy_num:int
@export var enemy_spawn_delay:int
@export var qtd_max_spawn: int = -1
var parent: Node2D
var qtd_spawned: int = 0

var spawn_delay_counter = 0

func spawning(position: Vector2, parent: Node2D):
	if (qtd_max_spawn == -1 || qtd_spawned < qtd_max_spawn):
		qtd_spawned += 1
		
		var animation_spawn: Node2D = spawn_animation.instantiate()
					
		animation_spawn.global_position = position
		animation_spawn.z_index = position.y
		animation_spawn.connect("Transitioned", on_state_machine_transition)
		parent.call_deferred("add_child", animation_spawn)

func on_state_machine_transition (state_machine: StateMachine, new_state_name: String):
	if (new_state_name == "LEAVING"):
		var enemy_spawn = enemy.instantiate()
		
		enemy_spawn.global_position = state_machine.global_position
		
		parent.call_deferred("add_child", enemy_spawn)
		state_machine.disconnect("Transitioned", on_state_machine_transition)
