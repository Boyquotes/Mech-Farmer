extends RigidBody3D

@export var damage = 40

var piercing

# func _on_body_entered(body:Node):
# 	if body.has_method("take_damage"):
# 		body.take_damage(damage)
# 		piercing -= 1
# 		linear_velocity = -global_transform.basis.z.normalized() * 20
# 	if piercing <= 0:
# 		queue_free()


func _on_area_3d_body_entered(body:Node3D):
	if body.has_method("take_damage"):
		body.take_damage(damage)
		piercing -= 1
		linear_velocity = -global_transform.basis.z.normalized() * 20
	if piercing <= 0:
		queue_free()

