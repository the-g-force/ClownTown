class_name Obstacle
extends StaticBody3D

const OBSTACLES := [
	"res://obstacles/models/obstacle_convertable.glb",
	"res://obstacles/models/obstacle_jeep.glb",
	"res://obstacles/models/obstacle_semi.glb",
	"res://obstacles/models/obstacle_sportscar.glb",
	"res://obstacles/models/obstacle_truck.glb",
]

var _model : Node3D


func _ready()->void:
	_add_model()
	_add_collision_shape()


func _add_model()->void:
	_model = load(OBSTACLES.pick_random()).instantiate()
	add_child(_model)
	_model.position.y = 0.5
	_model.rotation.y = PI


func _add_collision_shape()->void:
	var collision_shape := CollisionShape3D.new()
	collision_shape.shape = _get_box_shape()
	add_child(collision_shape)
	collision_shape.position = _model.position


func _get_box_shape()->BoxShape3D:
	var shape := BoxShape3D.new()
	shape.size = _model.get_node("mergedBlocks(Clone)").get_aabb().size
	return shape
