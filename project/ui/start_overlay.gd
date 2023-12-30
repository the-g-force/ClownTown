extends Control

func _ready():
	get_tree().paused = true


func _on_play_button_pressed():
	get_tree().paused = false
	queue_free()
