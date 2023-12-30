extends Node3D


func _on_visible_on_screen_notifier_3d_screen_entered():
	_add_next_block()


func _add_next_block() -> void:
	var next := duplicate()
	next.position.z -= 5
	get_parent().add_child(next)


func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()
