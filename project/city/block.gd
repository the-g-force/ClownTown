extends Node3D

const PERSON := preload("res://people/person.tscn")
const BUILDINGS := [
	preload("res://city/brownstone.tscn"),
	preload("res://city/barn.tscn"),
	preload("res://city/building.tscn"),
	preload("res://city/canopy.tscn"),
	preload("res://city/factory_1.tscn"),
	preload("res://city/factory_2.tscn"),
]

const OBSTACLES := [
	preload("res://obstacles/convertible.tscn"),
	preload("res://obstacles/jeep.tscn"),
	preload("res://obstacles/semi.tscn"),
	preload("res://obstacles/sports_car.tscn"),
	preload("res://obstacles/truck.tscn"),
]

var generate_obstacle := false

## Counts the number of empty blocks at the start of the game (without obstacles)
var empty_block_counter := 3

@onready var _building_marker_left := $Building_Left
@onready var _building_marker_right := $Building_Right


func _ready()->void:
	if generate_obstacle:
		_generate_obstacle()
	for _i in randi() % 2:
		call_deferred("_generate_person")
		
	# Create buildings
	for marker in [_building_marker_left, _building_marker_right]:
		var building :Node3D = BUILDINGS.pick_random().instantiate()
		marker.add_child(building)


func _generate_person()->void:
	var person_position := Vector3(
		-3.5 if randi() % 2 == 0 else 3.5,
		0.125,
		randf_range(-2.0, 2.0)
	)
	var person := PERSON.instantiate()
	get_parent().add_child(person)
	person.rotation.y = PI * (randi() % 2)
	person.global_position = global_position + person_position


func _generate_obstacle()->void:
	var lane_offset := Vector3(
		[-2.0, 0.0, 2.0].pick_random(),
		0.0,
		0.0
	)
	var obstacle :StaticBody3D = OBSTACLES.pick_random().instantiate()
	add_child(obstacle)
	obstacle.rotate_y(TAU/2)
	obstacle.position = lane_offset


func _on_visible_on_screen_notifier_3d_screen_entered():
	_add_next_block()


func _add_next_block() -> void:
	var next = load("res://city/block.tscn").instantiate()

	if empty_block_counter > 0:
		next.empty_block_counter = empty_block_counter - 1
	else:
		# Alternate which block has an obstacle
		next.generate_obstacle = not generate_obstacle
		next.empty_block_counter = 0
	
	get_parent().add_child(next)
	
	next.global_position = global_position
	next.position.z -= 5
	


func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()
