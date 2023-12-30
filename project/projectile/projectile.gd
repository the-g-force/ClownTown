class_name Projectile
extends RigidBody3D




func _on_lifetime_timer_timeout():
	queue_free()
