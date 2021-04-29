extends Area2D

export var speed = 600
var screen_size

func _ready():
	screen_size = get_viewport_rect().size

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _physics_process(delta):
	position += transform.x * speed * delta
