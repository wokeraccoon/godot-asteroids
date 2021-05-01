extends "res://GlobalAsteroid.gd"

func _ready():
	speed = rand_range(2,3) * 50
	random_scale =  rand_range(0.5,1)
	scale = Vector2(random_scale,random_scale)

func _on_SmallAsteroid_area_entered(area):
	queue_free()
	
func _on_SmallAsteroid_body_entered(body):
	body.on_collision()
	queue_free()
