extends KinematicBody2D

export var speed = 50 #player speed
export var max_speed = 100 #max player speed
export var rotation_speed = 4 #speed that the player can rotate in degrees (i think?)

export (PackedScene) var Bullet #saves bullet scene for later instancing it

var velocity = Vector2()
var rotation_dir = 0 #for determining what direction the player is turning

var screen_size #for storing the viewport's size

func _ready():
	screen_size = get_viewport_rect().size
	
	#starts the player in the middle of the screen
	position.x = screen_size.x/2
	position.y = screen_size.y/2

#function for getting the input of the player
func get_input():
	
	#resets rotation at start of the function so player doesnt rotate when no buttons is pressed
	rotation_dir = 0
	#rotates to the right and left
	if Input.is_action_pressed("right"):
		rotation_dir += 1
	if Input.is_action_pressed("left"):
		rotation_dir -= 1
	
	if Input.is_action_pressed("accelerate"):
		
		#adds 10 units to the acceleration of the player, then rotates the vector so the player moves to the angle its looking at.
		velocity += Vector2(speed, 0).rotated(rotation)
		#then clamps the velocity to the max speed so the player doesnt accelerate indefinitely
		velocity = velocity.clamped(max_speed)
	
	#pew pew!
	if Input.is_action_just_pressed("shoot"):
		shoot()

#warps the player for when it goes out of bounds.
func warp_object():
	
	if position.x >= (screen_size.x + 10):
		position.x = 0
	if position.x <= -10:
		position.x = screen_size.x
	
	if position.y >= (screen_size.y + 10):
		position.y = 0
	if position.y <= -10:
		position.y = screen_size.y

#function for instancing the bullet scene. Called when the player presses the "shoot" key
func shoot():
	#instances the bullet scene and stores it on the b variable
	var b =  Bullet.instance()
	#adds a bullet as a child of the root node of the scene
	#This is so the bullet can move on its own, rather than inherithing the player's transform
	owner.add_child(b)
	#sets the spawn point of the bullet to the player's "gun"
	b.transform = $Gun.global_transform

func _physics_process(delta):
	get_input()
	
	#rotates player
	rotation += rotation_dir * rotation_speed * delta
	#moves the player
	velocity = move_and_slide(velocity)
	
	warp_object()
