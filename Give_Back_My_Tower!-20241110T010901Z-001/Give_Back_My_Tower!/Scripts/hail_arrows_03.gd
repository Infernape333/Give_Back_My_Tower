extends Area2D


var inimigos_na_area: Array = []

func _physics_process(delta):
	for inimigo in inimigos_na_area:
		#if inimigo.is_valid():  # Verifica se o inimigo ainda existe
			inimigo.hurtFire()

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		inimigos_na_area.append(body)

func _on_body_exited(body):
	if body.is_in_group("enemies"):
		inimigos_na_area.erase(body)

func destroir():
	queue_free()

