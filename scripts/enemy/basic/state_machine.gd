extends CharacterBody3D

signal state_changed

var states_stack = []
var current_state = null

@onready var target = get_node("%Player")
@onready var states_map = {
	"idle": $States/Idle,
	"move": $States/Move,
}

func _ready():
	for state_node in $States.get_children():
		state_node.finished.connect(_change_state)
	states_stack.push_front($States/Idle)
	current_state = states_stack[0]
	_change_state("move")

func _physics_process(delta):
	current_state.update(delta)

func _change_state(state_name):
	current_state.exit()

	if state_name == "previous":
		states_stack.pop_front()
	else:
		var new_state = states_map[state_name]
		states_stack[0] = new_state

	current_state = states_stack[0]
	if state_name != "previous":
		current_state.enter()
	emit_signal("state_changed", states_stack)

