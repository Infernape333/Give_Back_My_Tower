extends ProgressBar

var health = 0: set = _set_health 
@onready var player = get_tree().get_first_node_in_group("player")
@onready var damageBar = $DamageBar
@onready var timer = $TimerH

func _ready():
	update_health()
	VariaveisGlobais.update_health_bar()

func update_health():
	health = VariaveisGlobais.current_life
	max_value = VariaveisGlobais.max_life
	value = health

func _set_health(new_health):
	var prev_health = health
	health = min(max_value, new_health)
	value = health
	
	if health <= 0:
		player.die()
		queue_free()
	
	if health < prev_health:
		timer.start()
	else:
		damageBar.value = health
	
func heal(amount):
	health += amount
	health = min(max_value, health)
	value= health
	
func in_health(_health):
	health = _health
	max_value = VariaveisGlobais.max_life
	value = health
	damageBar.max_value = health
	damageBar.value = health


func _on_timer_h_timeout():
	damageBar.value = health
