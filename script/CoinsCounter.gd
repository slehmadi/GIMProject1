extends Panel

var collected_coins = 0
onready var coins_label = $Label

func _ready():
	coins_label.text = str(collected_coins)
	

func collect_coins():
	collected_coins += 1
	coins_label.text = str(collected_coins)
