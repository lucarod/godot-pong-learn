extends Control

signal new_round
signal exit

func _on_NewGameButton_pressed():
	emit_signal("new_round")


func _on_ExitButton_pressed():
	emit_signal("exit")
