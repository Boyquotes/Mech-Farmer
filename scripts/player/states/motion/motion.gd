extends "../state.gd"

var is_controller = true

func get_input_direction():
	var input_direction = Vector2()
	input_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input_direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return input_direction

func get_fire_input():
	if Input.is_action_pressed("fire_1"):
		owner.primary_gun_1.fire()
	if Input.is_action_pressed("fire_2"):
		owner.primary_gun_2.fire()
	if Input.is_action_just_pressed("secondary_fire_1"):
		owner.secondary_gun_1.target_node = owner.lock_on_target
		owner.secondary_gun_1.fire()
	if Input.is_action_just_pressed("secondary_fire_2"):
		owner.secondary_gun_2.target_node = owner.lock_on_target
		owner.secondary_gun_2.fire()

func aim_mouse():
	var space_state = owner.get_world_3d().direct_space_state
	var mouse_pos = get_viewport().get_mouse_position()
	var camera = get_tree().root.get_camera_3d()

	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_end = ray_origin + camera.project_ray_normal(mouse_pos) * 2000
	var ray_properties = PhysicsRayQueryParameters3D.create(ray_origin, ray_end, 16)
	var ray_array = space_state.intersect_ray(ray_properties)
	
	var hit_pos
	if ray_array.has("position"):
		hit_pos = ray_array["position"] + Vector3(0,1,0)
	else:
		hit_pos = Vector3()

	owner.torso.look_at(hit_pos)

func aim_controller(delta):
	var rotation_speed = 10
	var joystick = Input.get_vector("look_left", "look_right", "look_up", "look_down")

	if joystick.length_squared() > 0.1:
		var look_direction := joystick.normalized()
		var target_rotation := look_direction.angle_to(Vector2(0,1) * -1)
		owner.torso.rotation.y = lerp_angle(owner.torso.rotation.y, target_rotation, delta * rotation_speed)

func aim_controls(delta):
	if is_controller:
		aim_controller(delta)
	else:
		aim_mouse()

func _input(event):
	if event is InputEventMouseButton:
		is_controller = false
	elif event is InputEventJoypadButton:
		is_controller = true
