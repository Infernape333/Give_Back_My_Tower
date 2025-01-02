extends ProgressBar

@onready var Damage_bar = $DamageBar2
@onready var timer = $DamageBar2/Timer

var health = 0: set = _set_health

func _set_health(new_health):
	health = new_health
	health = clampi(health, 0, new_health)
	
	if health <= 0:
		queue_free()
	value = health
	update_damage_bar()

func init_health(_health):
	health = _health
	max_value = health
	value = health
	Damage_bar.max_value = health
	Damage_bar.value = health

func update_damage_bar():
	await get_tree().create_timer(1).timeout
	Damage_bar.value = value
