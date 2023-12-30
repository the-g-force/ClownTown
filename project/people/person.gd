extends Area3D


func _on_body_entered(body:PhysicsBody3D)->void:
	if body is Projectile:
		print("I'm a CLOOWN!!")
		body.queue_free()
