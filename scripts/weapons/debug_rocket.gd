extends CharacterBody3D

const SPEED = 1000

var target_node: Node3D

@onready var rocket_mesh = $RocketMesh
@export var damage = 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target_node ==null: 
		queue_free()
	else:
		var temp_velocity = global_position.direction_to(target_node.global_position)
		velocity = temp_velocity * SPEED * delta
		rocket_mesh.rotation.x = rocket_mesh.rotation.x + (1 * delta)
	
		look_at(target_node.global_position)
	move_and_slide()

func _physics_process(delta):
	if get_last_slide_collision() != null:
		var collider = get_last_slide_collision().get_collider()
		explode(collider)

func explode(collider):
	if collider.has_method("take_damage"):
		collider.take_damage(damage)
		queue_free()
