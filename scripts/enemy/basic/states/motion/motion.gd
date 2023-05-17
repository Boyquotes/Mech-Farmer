extends "../state.gd"

var navigation_agent: NavigationAgent3D
var movement_target_position: Vector3
var movement_speed: float = 2.0

func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)
