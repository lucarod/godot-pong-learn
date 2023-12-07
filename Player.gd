extends KinematicBody2D

signal update

export var speed = 250
var screen_size

var direction = Vector2()

func _ready():
	screen_size = get_viewport_rect().size

func _process(_delta):
	emit_signal("update")

func _physics_process(delta):
	if direction.length()>0:
		direction = direction.normalized() * speed
	var _collision = move_and_collide(direction * delta)
	
func start(pos):
	position = pos
	show()
