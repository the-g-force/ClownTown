extends Node3D

const PERSON := preload("res://people/person.tscn")

var generate_obstacle := false
var no_obstacle_index := 3


func _ready()->void:
	if generate_obstacle and no_obstacle_index <= 0:
		_generate_obstacle()
	for _i in randi() % 2:
		call_deferred("_generate_person")


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
	var obstacle_position := Vector3(
		[-2.0, 0.0, 2.0].pick_random(),
		0.0,
		0.0
	)
	var obstacle := preload("res://obstacles/obstacle.tscn").instantiate()
	get_parent().add_child(obstacle)
	obstacle.global_position = global_position + obstacle_position


func _on_visible_on_screen_notifier_3d_screen_entered():
	_add_next_block()


func _add_next_block() -> void:
	var next := duplicate()
	next.position.z -= 5
	next.generate_obstacle = not generate_obstacle
	next.no_obstacle_index = no_obstacle_index - 1
	get_parent().add_child(next)


func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()
