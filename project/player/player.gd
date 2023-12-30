class_name Player
extends Area3D

const PROJECTILE := preload("res://projectile/projectile.tscn")
const _PIE_ROTATION_SPEED := 0.1

@export var lane_width := 6.0
@export var lane_change_time := 0.5
@export var forward_speed := 2.0
@export var cooldown_time := 0.5
@export_group("Projectile Impulse")
@export var vertical_impulse := 5.0
@export var horizontal_impulse := 10.0
@export var forward_impulse := 10.0

var converts := 0
var _is_moving := false
var _can_shoot := true
var _current_lane := 1
var _pies_thrown := 0

@onready var _throw_sound := $ThrowSound
@onready var _crash_sound := $CrashSound
@onready var _pie_stand : Node3D = %PieStand

func _process(delta:float)->void:
	var direction : int = sign(Input.get_axis("move_left", "move_right"))
	if not _is_moving and direction != 0:
		var new_lane := _current_lane + direction
		if new_lane <= 2 and new_lane >= 0:
			_change_lanes(direction)
	var shoot_direction : int = sign(Input.get_axis("shoot_left", "shoot_right"))
	if shoot_direction != 0 and _can_shoot:
		_shoot(shoot_direction)
	position.z -= forward_speed * delta
	
	_pie_stand.rotate_object_local(Vector3.UP, _PIE_ROTATION_SPEED)


func _change_lanes(direction:int)->void:
	_is_moving = true
	var target_position := position.x + lane_width * direction
	await create_tween().tween_property(self, "position:x", target_position, lane_change_time).finished
	_current_lane += direction
	_is_moving = false


func _shoot(direction:int)->void:
	_pies_thrown += 1
	_throw_sound.play()
	_can_shoot = false
	var projectile := PROJECTILE.instantiate()
	get_parent().add_child(projectile)
	projectile.global_position = global_position
	projectile.player = self
	projectile.angular_velocity = Vector3(-2.0, 0, 0)
	var projectile_impulse := Vector3(direction * horizontal_impulse, vertical_impulse, -forward_speed - forward_impulse)
	projectile.apply_central_impulse(projectile_impulse)
	await get_tree().create_timer(cooldown_time).timeout
	_can_shoot = true


func _on_body_entered(_body:PhysicsBody3D)->void:
	var overlay := preload("res://ui/end_overlay.tscn").instantiate()
	overlay.pies_thrown = _pies_thrown
	overlay.converts = converts
	get_parent().add_child(overlay)
	_crash_sound.play()
