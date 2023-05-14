extends "on_ground.gd"

const SPEED = 5.0
@export var MAX_WALK_SPEED: float = 450
@export var MAX_RUN_SPEED: float = 700

func enter():
	speed = 0.0
	# owner.velocity = Vector3()

func hundle_input(event):
	return super.handle_input(event)

func update(delta):
	var input_direction = get_input_direction()
	if input_direction == Vector2():
		emit_signal("finished", "idle")

	move(input_direction)
	# TODO: Figure out toggle between mouse and controller
	# aim_mouse()
	aim_controller(delta)
	if Input.is_action_pressed("fire_1"):
		primary_gun_1.fire()
	if Input.is_action_pressed("fire_2"):
		primary_gun_2.fire()
	
func move(input_dir):
	var direction = (owner.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		owner.velocity.x = direction.x * SPEED
		owner.velocity.z = direction.z * SPEED
	else:
		owner.velocity.x = move_toward(velocity.x, 0, SPEED)
		owner.velocity.z = move_toward(velocity.z, 0, SPEED)
	owner.move_and_slide()
