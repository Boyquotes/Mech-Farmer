extends RigidBody3D

@export var damage = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body:Node):
	if body.has_method("take_damage"):
		body.take_damage(damage)
		queue_free()
