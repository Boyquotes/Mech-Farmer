extends ProgressBar

@onready var player = get_node("%Player")

func _on_player_health_adjust(health_value):
	self.value += health_value
