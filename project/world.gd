extends Node3D

static var _first_run := true

func _ready():
	if _first_run:
		var overlay := preload("res://ui/start_overlay.tscn").instantiate()
		add_child(overlay)
		await overlay.play_pressed
		$Camera3D.current = true
		_first_run = false
	else:
		$Camera3D.current = true
