extends Node

class_name StateMachine

@export var initial_state: State

signal Transitioned

var current_state: State
var states: Dictionary = {}

func _ready():
	for child in get_children():
		if (child is State):
			states[child.name.to_upper()] = child
			child.Transitioned.connect(on_state_transitioned)
	
	if (initial_state):
		initial_state.enter()
		current_state = initial_state

func _process(delta):
	if (current_state):
		current_state.update(delta)

func _physics_process(delta):
	if (current_state):
		current_state.physics_update(delta)

func on_state_transitioned(state: State, new_state_name: String) -> void:
	if (state == current_state):
		if (new_state_name == "queue_free"):
			queue_free()
			return
		
		var new_state_upper = new_state_name.to_upper()
		var new_state: State = states[new_state_upper]
		
		if (new_state):
			if (current_state):
				current_state.exit()
			
			new_state.enter()
			current_state = new_state
			emit_signal("Transitioned", self, new_state_upper)
