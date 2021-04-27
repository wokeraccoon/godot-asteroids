extends KinematicBody2D

export var speed = 10
export var rotation_speed = 3

var velocity = Vector2()
var rotation_dir = 0

var screen_size

func _ready():
	screen_size = get_viewport_rect().size

func get_input():
	rotation_dir = 0
	#velocity = Vector2()
	if Input.is_action_pressed("right"):
		rotation_dir += 1
	if Input.is_action_pressed("left"):
		rotation_dir -= 1
	if Input.is_action_pressed("accelerate"):
		velocity += Vector2(speed, 0).rotated(rotation)
	print(velocity)

func _physics_process(delta):
	get_input()
	
	rotation += rotation_dir * rotation_speed * delta
	velocity = move_and_slide(velocity)
	
	warp_player()
		

func warp_player():
	if position.x >= (screen_size.x + 10):
		position.x = 0
	if position.x <= -10:
		position.x = screen_size.x
	
	if position.y >= (screen_size.y + 10):
		position.y = 0
	if position.y <= -10:
		position.y = screen_size.y
