extends KinematicBody2D

var velocity : Vector2
var axis : Vector2
export var moveBy = 500

func _ready():
	pass 

func _process(delta):
	pass

func _physics_process(delta):
	velocity.x = 0
	axis.x = 0
	
	
	if Input.is_action_pressed("RIGHT"):
		axis.x += 1
	if Input.is_action_pressed("LEFT"):
		axis.x -= 1
	if Input.is_action_pressed("JUMP") and is_on_floor():
		velocity.y = -300
	
	if (axis.x):
		velocity.x = lerp(velocity.x, axis.x * moveBy, 0.3)
	else:
		velocity.x = lerp(velocity.x, 0, 0.1)
	
	velocity.y += 300 * delta
	
	velocity = move_and_slide(velocity, Vector2(0, -1))
	

	
