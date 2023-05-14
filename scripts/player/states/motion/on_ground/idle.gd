extends "on_ground.gd"

func handle_input(event):
	return super.handle_input(event)

func update(delta):
	var input_direction = get_input_direction()
	if input_direction:
		emit_signal("finished", "move")
	# TODO: Figure out toggle between mouse and controller
	# aim_mouse()
	aim_controller(delta)
	if Input.is_action_pressed("fire_1"):
		fire_primary_1()
