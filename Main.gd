extends Node

onready var hud = get_node("CanvasLayer/HUD")

var score_player = 0
var score_bot = 0

var max_score = 3

func _ready():
	new_game()

func _process(_delta):
	if $StartTimer.time_left > 1:
		hud.get_node("CountdownContainer/CenterContainer/ActionText").set_text(str(round($StartTimer.time_left)))

func new_game():
	score_player = 0
	score_bot = 0
	update_score()
	$CanvasLayer/GameOverScreen.set_visible(false)
	start_new_round()

func _on_StartTimer_timeout():
	hud.get_node("CountdownContainer").set_visible(false)
	$Ball.set_start_direction()

func _on_Field_goal_left():
	score_bot += 1
	update_score()
	$Ball.explode()
	
func _on_Field_goal_right():
	score_player += 1
	update_score()
	$Ball.explode()
		
func start_new_round():
	$Ball.reset()
	$Player.set_position(Vector2(100, 386))
	$Bot.set_position(Vector2(1266, 386))
	$StartTimer.start()
	hud.get_node("CountdownContainer").set_visible(true)

func update_score():
	hud.get_node("HBoxContainer/ScorePlayer").set_text(str(score_player))
	hud.get_node("HBoxContainer/ScoreBot").set_text(str(score_bot))

func show_winner(message):
	$CanvasLayer/GameOverScreen.set_visible(true)
	$CanvasLayer/GameOverScreen.get_node("VBoxContainer/ResultMessage").set_text(message)


func _on_GameOverScreen_new_round():
	new_game()


func _on_GameOverScreen_exit():
	get_tree().quit()


func _on_Ball_exploded():
	if score_bot == max_score:
		print("perdeu")
		show_winner("You Lose")
	elif score_player == max_score:
		show_winner("You Win!")
	else:
		start_new_round()
		
