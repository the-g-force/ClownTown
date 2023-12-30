class_name Projectile
extends RigidBody3D


func _on_timer_timeout()->void:
	queue_free()
