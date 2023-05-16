extends Node3D

@export var enemy_scene: PackedScene
@export var target: Node3D

@onready var can_spawn_timer = $CanSpawnTimer



func _on_can_spawn_timer_timeout():
	var enemy = enemy_scene.instantiate()  # Create an instance of the projectile scene
	owner.add_child(enemy)  # Add the projectile to the parent node
	
	enemy.transform = self.transform  # Set the starting position of the projectile
	enemy.target = target
	can_spawn_timer.start()