extends "../state.gd"


@onready var torso = owner.get_node("Torso/Guns")

func get_input_direction():
    var input_direction = Vector2()
    input_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
    input_direction.y = int(Input.is_action_pressed("move_backward")) - int(Input.is_action_pressed("move_forward"))
    return input_direction


func screen_point_to_ray():
    var space_state = owner.get_world_3d().direct_space_state
    var mouse_pos = get_viewport().get_mouse_position()
    var camera = get_tree().root.get_camera_3d()

    var ray_origin = camera.project_ray_origin(mouse_pos)
    var ray_end = ray_origin + camera.project_ray_normal(mouse_pos) * 2000
    var ray_properties = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
    var ray_array = space_state.intersect_ray(ray_properties)

    if ray_array.has("position"):
        return ray_array["position"]
    return Vector3()