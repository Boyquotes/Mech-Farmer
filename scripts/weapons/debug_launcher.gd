extends MeshInstance3D

@export var projectile_scene: PackedScene
@export var projectile_speed: int = 5
var target_node: Node3D

@onready var rocket_spawn = $RocketSpawn
@onready var fire_rate_timer: Timer = $FireRateTimer

var can_fire = true

func fire():
	
	if can_fire and target_node != null:
		
		var projectile = projectile_scene.instantiate()  # Create an instance of the projectile scene
		rocket_spawn.add_child(projectile)  # Add the projectile to the parent node
		
		projectile.position = rocket_spawn.position  # Set the starting position of the projectile
		projectile.rotation = rocket_spawn.rotation
		projectile.target_node = target_node
		projectile.top_level = true
		# projectile.rotation.y = projectile.rotation.y + 90
		# var direction = -rocket_spawn.global_transform.basis.z.normalized()  # Get the direction the projectile should travel
		
		# projectile.linear_velocity = direction * projectile_speed  # Set the velocity of the projectile
		# projectile.look_at(target_node.global_position)
		
		can_fire = false
		fire_rate_timer.start()

func _on_fire_rate_timer_timeout():
	can_fire = true
