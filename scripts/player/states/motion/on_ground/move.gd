extends "on_ground.gd"

func enter():
	speed = 10

func hundle_input(event):
	return super.handle_input(event)

func update(delta):
	var input_direction = get_input_direction()
	
	if input_direction == Vector2():
		emit_signal("finished", "idle")

	move(input_direction)
	aim_controls(delta)
	get_fire_input()
	
func move(input_dir):
	var direction = (owner.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		owner.velocity.x = direction.x * speed
		owner.velocity.z = direction.z * speed
	else:
		owner.velocity.x = move_toward(velocity.x, 0, speed)
		owner.velocity.z = move_toward(velocity.z, 0, speed)
	owner.move_and_slide()
