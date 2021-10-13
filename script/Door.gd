extends Area2D

export(NodePath) var player_path
onready var player = get_node(player_path)

export(NodePath) var coins_collected_path
onready var coins_collected = get_node(coins_collected_path)

onready var popup = get_node("PopupPanel")

func _ready():
	popup.hide()
	


func _on_Door_body_entered(body):
	if (body == player):
		popup.show()
		if Input.is_key_pressed(KEY_E):
			if exit_cond(coins_collected.collected_coins):
				pass

func _on_Door_body_exited(body):
	popup.hide()

func exit_cond(coins):
	if (coins == 5):
		return true
	return false
