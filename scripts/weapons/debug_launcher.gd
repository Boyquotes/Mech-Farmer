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
		
		projectile.transform = rocket_spawn.transform  # Set the starting position of the projectile

		projectile.target_node = target_node
		
		projectile.top_level = true
		
		can_fire = false
		fire_rate_timer.start()

func _on_fire_rate_timer_timeout():
	can_fire = true
