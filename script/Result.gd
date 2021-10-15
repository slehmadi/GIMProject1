extends Panel

export(NodePath) var coins_collected_path
onready var coins_collected = get_node(coins_collected_path)
onready var total = $Total

func _ready():
	hide()

func result():
	show()
	total.text = str(coins_collected.collected_coins) + "/3"
