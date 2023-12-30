extends Area3D

@export var lane_width := 6.0
@export var lane_change_time := 0.5

var _is_moving := false


func _process(_delta:float)->void:
	var motion_axis := Input.get_axis("move_left", "move_right")
	if not _is_moving and motion_axis != 0:
		_change_lanes(sign(motion_axis))


func _change_lanes(direction:int)->void:
	_is_moving = true
	var target_position := position + Vector3.RIGHT * lane_width * direction
	await create_tween().tween_property(self, "position", target_position, lane_change_time).finished
	_is_moving = false
