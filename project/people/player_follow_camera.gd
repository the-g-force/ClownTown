class_name PlayerFollowCamera
extends Camera3D

@export var player : Player
@export var distance_behind_player := 6.0


func _ready()->void:
	global_position.x = player.global_position.x


func _process(_delta:float)->void:
	global_position.z = player.global_position.z + distance_behind_player
