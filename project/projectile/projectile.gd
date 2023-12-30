class_name Projectile
extends RigidBody3D

var player : Player


func resolve_made_clown()->void:
	player.converts += 1
	queue_free()


func _on_lifetime_timer_timeout():
	queue_free()
