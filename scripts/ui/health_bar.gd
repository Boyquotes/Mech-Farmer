extends ProgressBar

@onready var player = get_node("%Player")

func _ready():
	player.health_adjust.connect(_on_player_health_adjust)

func _on_player_health_adjust(health_value):
	self.value = health_value
