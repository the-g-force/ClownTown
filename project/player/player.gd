extends Area3D

@export var lane_width := 6.0
@export var lane_change_time := 0.5
@export var forward_speed := 2.0

var _is_moving := false
var _current_lane := 1


func _process(delta:float)->void:
	var direction : int = sign(Input.get_axis("move_left", "move_right"))
	if not _is_moving and direction != 0:
		var new_lane := _current_lane + direction
		if new_lane <= 2 and new_lane >= 0:
			_change_lanes(direction)
	position.z -= forward_speed * delta


func _change_lanes(direction:int)->void:
	_is_moving = true
	var target_position := position.x + lane_width * direction
	await create_tween().tween_property(self, "position:x", target_position, lane_change_time).finished
	_current_lane += direction
	_is_moving = false
