extends CharacterBody3D

const SPEED = 1000

var target_node: Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	print("start")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var temp_velocity = global_position.direction_to(target_node.global_position)
	velocity = temp_velocity * SPEED * delta
	
	print(temp_velocity)
	move_and_slide()
