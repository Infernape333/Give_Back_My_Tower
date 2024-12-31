extends Area2D

var player_inside = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if VariaveisGlobais.door_choice == 1:
		queue_free()
		
func _on_body_entered(body):
	if body.name == "Player":
			player_inside = true
func _on_body_exited(body):
	if body.name == "Player":
			player_inside = false

func _input(event):
	if event.is_action_pressed("Interaction") and player_inside:
		pegar_upd()

func pegar_upd():
	var animation_name = $Sprite2D.animation
	match animation_name:
		"Atk":
			VariaveisGlobais.dano += 2.5
		"Atk_Incommun":
			VariaveisGlobais.dano += 5
		"Atk_Rare":
			VariaveisGlobais.dano += 7.5
		"Atk_Epic":
			VariaveisGlobais.dano += 10
		"Atk_Legendary":
			VariaveisGlobais.dano += 15
		"Atk_Spd":
			VariaveisGlobais.atk_spd -= 0.10
		"Atk_Spd_Incommum":
			VariaveisGlobais.atk_spd -= 0.20
		"Atk_Spd_Rare":
			VariaveisGlobais.atk_spd -= 0.30
		"Atk_Spd_Epic":
			VariaveisGlobais.atk_spd -= 0.40
		"Atk_Spd_Epic":
			VariaveisGlobais.atk_spd -= 0.50
		"Hp":
			VariaveisGlobais.max_life += 5
		"Hp_Incommum":
			VariaveisGlobais.max_life += 10
		"Hp_Rare":
			VariaveisGlobais.max_life += 15
		"Hp_Epic":
			VariaveisGlobais.max_life += 20
		"Hp_Legendary":
			VariaveisGlobais.max_life += 25
	VariaveisGlobais.door_choice += 1
	queue_free()








