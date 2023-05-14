extends MeshInstance3D

@export var projectile_scene: PackedScene
@export var projectile_speed = 20

@onready var bullet_spawn = $BulletSpawn

func  fire():

	var projectile = projectile_scene.instantiate()  # Create an instance of the projectile scene
	bullet_spawn.add_child(projectile)  # Add the projectile to the parent node
	
	projectile.transform = bullet_spawn.transform  # Set the starting position of the projectile
	
	var direction = -bullet_spawn.global_transform.basis.z.normalized()  # Get the direction the projectile should travel
	
	projectile.linear_velocity = direction * projectile_speed  # Set the velocity of the projectile
	projectile.top_level = true