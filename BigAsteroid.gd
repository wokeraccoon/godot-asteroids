extends Area2D

var random_rotation_speed
var speed
var screen_size
var random_scale

var random = RandomNumberGenerator.new()
	
func _ready():
	screen_size = get_viewport_rect().size
	random_rotation_speed = rand_range(-1,1)*5
	rotation_degrees = rand_range(0,359)
	speed = rand_range(1,2) * 50
	
	random_scale =  rand_range(1.5,2)
	scale = Vector2(random_scale,random_scale)

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


func _on_Asteroid_area_entered(area):
	queue_free()
