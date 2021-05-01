extends Node2D

export (PackedScene) var asteroid

var random = RandomNumberGenerator.new()
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	randomize()

func generate_asteroid():
	var ast = asteroid.instance()
	add_child(ast)
	
	var random_y = randi() % 10
	
	if random_y < 5:
		ast.position =  Vector2(random.randf_range(0,screen_size.x), -15)
	else:
		ast.position =  Vector2(random.randf_range(0,screen_size.x), screen_size.y+15)


func _on_Timer_timeout():
	var asteroid_count = get_tree().get_nodes_in_group("asteroids").size()
	if asteroid_count <= 4:
		generate_asteroid()
