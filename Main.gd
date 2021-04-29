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
	ast.position =  Vector2(random.randf_range(0,screen_size.x), random.randf_range(0,screen_size.y))


func _on_Timer_timeout():
	generate_asteroid()
