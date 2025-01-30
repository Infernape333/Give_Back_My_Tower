extends HBoxContainer

var slots: Array

func _ready():
	slots = get_children()
	for i in get_child_count():
		slots[i].change_key = str(i+1)
	
	slots[0].skill = blockAttack.new(slots[0])
	slots[1].skill = vortexBlade.new(slots[1])
	slots[2].skill = flamingBlade.new(slots[2])

