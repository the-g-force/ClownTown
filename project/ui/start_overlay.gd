extends Control

signal play_pressed

func _ready():
	get_tree().paused = true
	$PlayButton.grab_focus()


func _on_play_button_pressed():
	get_tree().paused = false
	play_pressed.emit()
	queue_free()
