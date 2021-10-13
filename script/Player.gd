extends KinematicBody2D

export var velocity : Vector2
var axis : Vector2
export var moveBy = 500
export var jumpForce = -300
export var gravity = 320
onready var camera = $Camera2D


func _ready():
	camera.limit_left = 0
	camera.limit_right = 1612
	camera.limit_bottom = 690
	camera.limit_top = 0

func _physics_process(delta):
	axis.x = 0
	inputPlayer()
	playerAct(delta)
	if (self.position.y >= 693):
		self.position.x = 255
		self.position.y = 200

func inputPlayer():
	if Input.is_action_pressed("RIGHT"):
		if is_on_floor():
			axis.x += 0.8
		else:
			if velocity.y < 0:
				axis.x += 0.5
			else:
				axis.x += 0.6
	if Input.is_action_pressed("LEFT"):
		if is_on_floor():
			axis.x -= 0.8
		else:
			if velocity.y < 0:
				axis.x -= 0.5
			else:
				axis.x -= 0.6
	if Input.is_action_pressed("JUMP") and is_on_floor():
		velocity.y = jumpForce
	if Input.is_action_pressed("DOWN") and !is_on_floor():
		velocity.y = gravity * 2

func playerAct(delta):
	if (axis.x):
		if is_on_floor() and !is_on_wall():
			$AnimatedSprite.animation = "walk"
		if is_on_floor() and is_on_wall():
			$AnimatedSprite.animation = "push"
		if !is_on_floor():
			jumpCondition()
		velocity.x = lerp(velocity.x, axis.x * moveBy, 0.1)
		if (axis.x < 0):
			$AnimatedSprite.flip_h = true
		if (axis.x > 0):
			$AnimatedSprite.flip_h = false
	else:
		if is_on_floor():
			$AnimatedSprite.animation = "idle"
		else:
			jumpCondition()
		velocity.x = lerp(velocity.x, 0, 0.1)
	
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2(0, -1))

func jumpCondition():
	if (velocity.y < 0):
		$AnimatedSprite.animation = "jumpUp"
	else:
		$AnimatedSprite.animation = "jumpDown"


