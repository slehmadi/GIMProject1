extends KinematicBody2D

export(NodePath) var door_path
onready var door = get_node(door_path)

export(NodePath) var doorPopup_path
onready var doorPopup = get_node(doorPopup_path)

export(NodePath) var finishOption_path
onready var finishOption = get_node(finishOption_path)

export(NodePath) var result_path
onready var result = get_node(result_path)

onready var camera = $Camera2D
var velocity : Vector2
var axis : Vector2
var moveBy = 500
var jumpForce = -300
var gravity = 320

var chooseOption = false
var tabOpen = false

func _ready():
	camera.limit_left = 0
	camera.limit_right = 1612
	camera.limit_bottom = 690
	camera.limit_top = 0
	finishOption.hide()

func _physics_process(delta):
	axis.x = 0
	if !chooseOption:
		inputPlayer()
		playerAct(delta)
	if (self.position.y >= 693):
		self.position.x = 255
		self.position.y = 200
	chooseOptionStatus()
	

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

func chooseOptionStatus():
	if Input.is_key_pressed(KEY_F) and door.inside:
		doorPopup.hide()
		finishOption.show()
		tabOpen = true
		chooseOption = true
	elif door.inside and tabOpen:
		if Input.is_key_pressed(KEY_E):
			hide()
			finishOption.hide()
			result.result()
		elif Input.is_key_pressed(KEY_Q):
			chooseOption = false
			tabOpen = false
			finishOption.hide()
			doorPopup.show()


