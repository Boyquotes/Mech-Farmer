extends RigidBody3D

@export var damage = 10

func _on_body_entered(body:Node):
	if body.has_method("take_damage"):
		body.take_damage(damage)
		queue_free()
