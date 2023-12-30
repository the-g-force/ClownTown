extends Area3D

enum Lanes {LEFT, CENTER, RIGHT}

@export var lane_width := 6.0
@export var lane_change_time := 0.5

var _is_moving := false
var _current_lane := Lanes.CENTER


func _process(_delta:float)->void:
	var direction := signf(Input.get_axis("move_left", "move_right"))
	if not _is_moving and direction != 0:
		if not (direction < 0 and _current_lane == Lanes.LEFT) and (not
				(direction > 0 and _current_lane == Lanes.RIGHT)):
			_change_lanes(direction)


func _change_lanes(direction:int)->void:
	_is_moving = true
	var target_position := position + Vector3.RIGHT * lane_width * direction
	await create_tween().tween_property(self, "position", target_position, lane_change_time).finished
	_current_lane += direction
	_is_moving = false
