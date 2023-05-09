extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
 
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

signal health_adjust(health_value)
signal game_over

@export var bullet_scene: PackedScene
@export var max_health:= 20

@onready var torso = get_node("Torso/Guns")
@onready var health = max_health
@onready var invincible := false

func _ready():
	health_adjust.emit(health)

func _physics_process(delta):
	
	# Add the gravity.

	torso.look_at(screen_point_to_ray())

	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle Primary Fire
	# if Input.is_action_just_pressed("fire_primary"):
	# 	primary_fire()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func screen_point_to_ray():
	var space_state = get_world_3d().direct_space_state
	var mouse_pos = get_viewport().get_mouse_position()
	var camera = get_tree().root.get_camera_3d()

	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_end = ray_origin + camera.project_ray_normal(mouse_pos) * 2000
	var ray_properties = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
	var ray_array = space_state.intersect_ray(ray_properties)

	if ray_array.has("position"):
		return ray_array["position"]
	return Vector3()

func primary_fire():
	var bullet = bullet_scene.instantiate()
	var bullet_spawn_location = torso.position
	add_child(bullet)

func take_damage(damage_value):
	if invincible:
		return
	health -= damage_value
	health_adjust.emit(health)
	check_death()

func take_heal(heal_value):
	health += heal_value
	health_adjust.emit(health)
	
func check_death():
	if health <= 0:
		game_over.emit()



