extends KinematicBody2D

export var speed = 10
export var max_speed = 150
export var rotation_speed = 3

export (PackedScene) var Bullet

var velocity = Vector2()
var rotation_dir = 0

var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	
	position.x = screen_size.x/2
	position.y = screen_size.y/2

func get_input():
	rotation_dir = 0
	#velocity = Vector2()
	if Input.is_action_pressed("right"):
		rotation_dir += 1
	if Input.is_action_pressed("left"):
		rotation_dir -= 1
	if Input.is_action_pressed("accelerate"):
		velocity += Vector2(speed, 0).rotated(rotation)
		velocity = velocity.clamped(max_speed)
	if Input.is_action_just_pressed("shoot"):
		shoot()

func warp_player():
	if position.x >= (screen_size.x + 10):
		position.x = 0
	if position.x <= -10:
		position.x = screen_size.x
	
	if position.y >= (screen_size.y + 10):
		position.y = 0
	if position.y <= -10:
		position.y = screen_size.y

func shoot():
	var b =  Bullet.instance()
	owner.add_child(b)
	b.transform = $Gun.global_transform

func _physics_process(delta):
	get_input()
	
	rotation += rotation_dir * rotation_speed * delta
	velocity = move_and_slide(velocity)
	
	warp_player()
