extends HBoxContainer

var slots: Array

func _ready():
	slots = get_children()
	for i in get_child_count():
		slots[i].change_key = str(i+1)
	
	slots[0].skill = triptychShot.new(slots[0])
	slots[1].skill = IceSpikes.new(slots[1])
	slots[2].skill = DarkSkull.new(slots[2])

