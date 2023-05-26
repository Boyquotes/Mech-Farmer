extends MeshInstance3D

@export var projectile_scene: PackedScene
@export var projectile_speed: int = 20

@onready var flame_spawn = $FlameSpawn
@onready var fire_rate_timer: Timer = $FireRateTimer

var can_fire = true

func fire():
	if can_fire:
		var projectile = projectile_scene.instantiate()  # Create an instance of the projectile scene
		flame_spawn.add_child(projectile)  # Add the projectile to the parent node
		
		projectile.transform = flame_spawn.transform  # Set the starting position of the projectile				
		projectile.top_level = true
		
		can_fire = false
		fire_rate_timer.start()

func _on_fire_rate_timer_timeout():
	can_fire = true
