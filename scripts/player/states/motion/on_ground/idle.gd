extends "on_ground.gd"

func handle_input(event):
	return super.handle_input(event)

func update(delta):
	var input_direction = get_input_direction()
	if input_direction:
		emit_signal("finished", "move")
	screen_point_to_ray()
	torso.look_at(screen_point_to_ray())
