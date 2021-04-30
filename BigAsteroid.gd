extends Area2D

export (PackedScene) var small_asteroid

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
	if position.x >= (screen_size.x + 15):
		position.x = 0
	if position.x <= -15:
		position.x = screen_size.x
	
	if position.y >= (screen_size.y + 15):
		position.y = 0
	if position.y <= -15:
		position.y = screen_size.y

func generate_small_asteroid():
	for i in (2):
		var sast = small_asteroid.instance()
		get_parent().add_child(sast)
		sast.transform = global_transform
		if i == 0:
			sast.rotation_degrees = rotation_degrees + 90
		else:
			sast.rotation_degrees = rotation_degrees + 270
	pass

func _on_BigAsteroid_area_entered(area):
	generate_small_asteroid()
	queue_free()

func _on_BigAsteroid_body_entered(body):
	body.on_collision()
	queue_free()
