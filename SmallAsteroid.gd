extends Area2D

var random_rotation_speed
var speed
var screen_size
var random_scale

var random = RandomNumberGenerator.new()
	
func _ready():
	screen_size = get_viewport_rect().size
	random_rotation_speed = rand_range(-1,1)*5
	speed = rand_range(2,3) * 50

func _process(delta):
	$Sprite.rotation += random_rotation_speed * delta
	position += transform.x * speed * delta
	warp_object()

func warp_object():
	if position.x >= (screen_size.x + 15):
		position.x = 0
	if position.x <= -15:
		position.x = screen_size.x
	
	if position.y >= (screen_size.y + 15):
		position.y = 0
	if position.y <= -15:
		position.y = screen_size.y

func _on_SmallAsteroid_area_entered(area):
	queue_free()
	
func _on_SmallAsteroid_body_entered(body):
	body.on_collision()
	queue_free()
