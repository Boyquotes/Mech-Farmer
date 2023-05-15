extends "../state.gd"


@onready var torso = owner.get_node("Torso")
@onready var primary_gun_1 = torso.get_node("PrimarySlot1/PrimaryGun")
@onready var primary_gun_2 = torso.get_node("PrimarySlot2/PrimaryGun")

var is_controller = true

func get_input_direction():
	var input_direction = Vector2()
	input_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input_direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return input_direction


func aim_mouse():
	var space_state = owner.get_world_3d().direct_space_state
	var mouse_pos = get_viewport().get_mouse_position()
	var camera = get_tree().root.get_camera_3d()

	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_end = ray_origin + camera.project_ray_normal(mouse_pos) * 2000
	var ray_properties = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
	var ray_array = space_state.intersect_ray(ray_properties)

	var hit_pos
	if ray_array.has("position"):
		hit_pos = ray_array["position"] + Vector3(0,1,0)
	else:
		hit_pos = Vector3()

	torso.look_at(hit_pos)

func aim_controller(delta):
	var rotation_speed = 10
	var joystick = Input.get_vector("look_left", "look_right", "look_up", "look_down")

	if joystick.length_squared() > 0.1:
		var look_direction := joystick.normalized()
		var target_rotation := look_direction.angle_to(Vector2(0,1) * -1)
		torso.rotation.y = lerp_angle(torso.rotation.y, target_rotation, delta * rotation_speed)

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
