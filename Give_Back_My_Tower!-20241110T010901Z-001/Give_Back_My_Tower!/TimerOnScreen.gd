extends CanvasLayer

@onready var label = $Label
@onready var timer = $Timer
@onready var total_time: int = 15


func _ready():
	match get_tree().current_scene.name:
		"Floor1":
			total_time = 60
		"Floor2":
			total_time = 75
		"Floor3":
			total_time = 90
		"Floor4":
			total_time = 105
		"Floor5":
			total_time = 120
	
	timer.start()

func _on_timer_timeout():
	total_time -= 1
	var m = int(total_time/ 60)
	var s = total_time % 60
	$Label.text = "%02d:%02d" % [m, s]
	if total_time <= 0:
		label.queue_free()
		timer.stop()
