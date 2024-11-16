extends ProgressBar

var health = 0: set = _set_health
@onready var Wizard = get_tree().get_first_node_in_group("EvilWizard")
@onready var damageBar = $DamageWizard
@onready var timer = $Timer

func _ready():
	pass

func _set_health(new_health):
	var prev_health = health
	health = min(max_value, new_health)
	value = health
	
	if health <= 0:
		Wizard.die()
		queue_free()
	
	if health < prev_health:
		timer.start()
	else:
		damageBar.value = health
	

func in_health(_health):
	health = _health
	max_value = health
	value = health
	damageBar.max_value = health
	damageBar.value = health


func _on_timer_h_timeout():
	damageBar.value = health

