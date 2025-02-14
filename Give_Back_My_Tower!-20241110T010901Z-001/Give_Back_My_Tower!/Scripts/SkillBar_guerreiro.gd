extends HBoxContainer

var slots: Array
var controller_buttons = [JOY_BUTTON_X, JOY_BUTTON_A, JOY_BUTTON_B]

func _ready():
	slots = get_children()
	for i in get_child_count():
		slots[i].change_key = str(i+1)
		slots[i].add_controller_button(controller_buttons[i])
	
	slots[0].skill = blockAttack.new(slots[0])
	slots[1].skill = vortexBlade.new(slots[1])
	slots[2].skill = flamingBlade.new(slots[2])

