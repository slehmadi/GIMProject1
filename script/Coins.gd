extends Area2D

export(NodePath) var coins_collected_path

onready var coins_collected = get_node(coins_collected_path)
var picked = false

func _ready():
	$AnimatedSprite.animation = "default"

func _on_body_entered(_body):
	$AnimatedSprite.animation = "picked"
	if (picked == false):
		coins_collected.collect_coins()
		picked = true

func _on_animation_finished():
	if $AnimatedSprite.animation == "picked":
		queue_free()
