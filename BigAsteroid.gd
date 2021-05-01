extends "res://GlobalAsteroid.gd"

export (PackedScene) var small_asteroid

func _ready():
	speed = rand_range(1,2) * 50
	random_scale =  rand_range(1.5,2)
	scale = Vector2(random_scale,random_scale)

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
