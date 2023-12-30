extends Area3D

@export var lane_width := 6.0

var _is_moving := false


func _process(delta:float)->void:
	var motion_axis := Input.get_axis("move_left", "move_right")
	if not _is_moving and motion_axis != 0:
		_is_moving = true
		await create_tween().tween_property(self, "position", position + Vector3.RIGHT * lane_width * sign(motion_axis), 0.5).finished
		_is_moving = false
