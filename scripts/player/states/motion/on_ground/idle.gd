extends "on_ground.gd"

func handle_input(event):
	return super.handle_input(event)

func update(delta):
	var input_direction = get_input_direction()
	if input_direction:
		emit_signal("finished", "move")
	aim_controls(delta)
	get_fire_input()

