extends CharacterBody3D

const SPEED = 1000

var target_node: Node3D

@onready var rocket_mesh = $RocketMesh
@export var damage = 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target_node ==null: 
		queue_free()
	else:
		var temp_velocity = global_position.direction_to(target_node.global_position)
		velocity = temp_velocity * SPEED * delta
		rocket_mesh.rotation.x = rocket_mesh.rotation.x + (1 * delta)
	
		look_at(target_node.global_position)
	
	move_and_slide()


func _on_area_3d_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)

