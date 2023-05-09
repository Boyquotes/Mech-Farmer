extends Node

@onready var debug_container = get_node("DebugContainer")
@onready var states_label = get_node("DebugContainer/StatesLabel")
@onready var player = get_node("%Player")
@onready var health_bar = get_node("%HealthBar")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("debug_menu"):
		debug_container.visible = !debug_container.visible

func _on_game_over_button_button_down():
	player.take_damage(player.health)
		
func _on_refill_health_button_pressed():
	player.take_heal(player.max_health - player.health)

func _on_invincible_button_button_up():
	player.invincible = false

func _on_invincible_button_button_down():
	player.invincible = true

func _on_player_state_changed(states_stack):
	
	var states_names = ''
	var numbers = ''
	var index = 0
	for state in states_stack:
		states_names += state.get_name() + '\n'
		numbers += str(index) + '\n'
		index += 1
	states_label.text = states_names