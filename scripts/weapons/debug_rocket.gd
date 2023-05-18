extends CharacterBody3D

const SPEED = 1000

var target_node: Node3D

@onready var rocket_mesh = $RocketMesh

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# pass
	var temp_velocity = global_position.direction_to(target_node.global_position)
	velocity = temp_velocity * SPEED * delta
	rocket_mesh.rotation.x = rocket_mesh.rotation.x + (1 * delta)
	
	look_at(target_node.global_position)
	
	move_and_slide()
