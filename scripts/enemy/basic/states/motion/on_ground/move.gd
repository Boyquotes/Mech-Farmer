extends "on_ground.gd"

func enter():
	navigation_agent = owner.navigation_agent
	
	

func update(delta):
	# movement_target_position = owner.target_node.position
	set_movement_target(owner.target_node.position)
	if navigation_agent.is_navigation_finished():
		return

	var current_agent_position: Vector3 = owner.global_position
	var next_path_position: Vector3 = navigation_agent.get_next_path_position()

	var new_velocity: Vector3 = next_path_position - current_agent_position
	new_velocity = new_velocity.normalized()
	new_velocity = new_velocity * movement_speed

	owner.velocity = new_velocity
	owner.move_and_slide()
