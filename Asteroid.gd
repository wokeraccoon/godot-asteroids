extends Area2D

var random_rotation_speed
var speed
var screen_size

var random = RandomNumberGenerator.new()
	
func _ready():
	randomize()
	
	screen_size = get_viewport_rect().size
	random_rotation_speed = rand_range(-1,1)*5
	rotation_degrees = rand_range(0,359)
	speed = rand_range(2,4) * 100
	
	position = Vector2(screen_size.x/2,screen_size.y/2)

func _process(delta):
	$Sprite.rotation += random_rotation_speed * delta
	position += transform.x * speed * delta
	warp_object()

func warp_object():
	if position.x >= (screen_size.x + 10):
		position.x = 0
	if position.x <= -10:
		position.x = screen_size.x
	
	if position.y >= (screen_size.y + 10):
		position.y = 0
	if position.y <= -10:
		position.y = screen_size.y
