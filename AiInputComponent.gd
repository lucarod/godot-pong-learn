extends Node

class_name AiInputComponent

export (NodePath) var ball_path
onready var ball = get_node(ball_path)

var racket

func _ready():
	racket = get_parent()
	racket.connect("update", self, "calculate_velocity")

func calculate_velocity():
	if not "direction" in racket:
		return
		
	racket.direction = Vector2(0, get_ball_direction())
	
func get_ball_direction():
	if abs(racket.position.y - ball.position.y) > 25:
		if racket.position.y < ball.position.y:
			return 1
		else:
			return -1
	else: return 0
