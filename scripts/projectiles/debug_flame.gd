extends Area3D

@export var damage = 0.5

var enemy_stay_dict = {}

# Called when the node enters the scene tree for the first time.

func _ready():
	var tween = get_tree().create_tween()

	tween.tween_property(self, "scale", Vector3(6,1,12), 1)
	tween.play()
	tween.tween_callback(self.queue_free)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for enemy in enemy_stay_dict:
		if enemy.has_method("take_damage"):
			enemy.take_damage(damage)
	
func _on_body_entered(body:Node3D):
	enemy_stay_dict[body] = null

func _on_body_exited(body):
	enemy_stay_dict.erase(body)
