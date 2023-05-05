extends ProgressBar

@onready var player = get_node("%Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	player.health_adjust.connect(_on_Health_Adjust)

func _on_Health_Adjust(health_value):
	self.value += health_value

func _on_game_over_button_button_down():
	self.value = 0
	player.health = 0

func _on_invincible_button_button_down():
	player.invincible = true

func _on_invincible_button_button_up():
	player.invincible = false

func _on_refill_health_button_pressed():
	player.take_heal(player.max_health - player.health)
