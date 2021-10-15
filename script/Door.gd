extends Area2D

export(NodePath) var player_path
onready var player = get_node(player_path)

export(NodePath) var coins_collected_path
onready var coins_collected = get_node(coins_collected_path)

export(NodePath) var finishOption_path
onready var finishOption = get_node(finishOption_path)

onready var popup = get_node("PopupPanel")
var inside = false

func _ready():
	popup.hide()

func _on_Door_body_entered(body):
	if (body == player):
		popup.show()
		inside = true

func _on_Door_body_exited(body):
	popup.hide()


