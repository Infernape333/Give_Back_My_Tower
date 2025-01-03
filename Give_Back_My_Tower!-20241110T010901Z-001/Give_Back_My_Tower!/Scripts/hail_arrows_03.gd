extends Area2D


var inimigos_na_area: Array = []
var dano_por_segundo: float = 1.0  # Tempo entre danos em segundos

func _ready():
	# Adiciona um Timer à cena
	var timer = Timer.new()
	timer.wait_time = dano_por_segundo
	timer.autostart = true
	timer.one_shot = false
	timer.timeout.connect(_aplicar_dano)
	add_child(timer)

func _aplicar_dano():
	for inimigo in inimigos_na_area:
		inimigo.hurtFire()

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		inimigos_na_area.append(body)

func _on_body_exited(body):
	if body.is_in_group("enemies"):
		inimigos_na_area.erase(body)

func destroir():
	queue_free()

