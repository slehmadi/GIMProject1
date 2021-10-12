extends Area2D

export(NodePath) var coins_collected_path
onready var collected_coins = get_node(coins_collected_path)

func _ready():
	$AnimatedSprite.animation = "default"

func _on_body_entered(_body):
	$AnimatedSprite.animation = "picked"
	collected_coins.collect_coins()

func _on_animation_finished():
	if $AnimatedSprite.animation == "picked":
		queue_free()
