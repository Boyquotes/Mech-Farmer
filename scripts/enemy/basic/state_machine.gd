extends CharacterBody3D

signal state_changed

var states_stack = []
var current_state = null

@export var max_health:= 40
@export var target_node: Node3D
@export var repair_pack_scene: PackedScene

@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
@onready var health = max_health
@onready var invincible := false

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

func ready_navigation():
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	navigation_agent.path_desired_distance = 0.5
	navigation_agent.target_desired_distance = 0.5

	# Make sure to not await during _ready.
	call_deferred("actor_setup")

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

func take_damage(damage_value):
	if invincible:
		return
	health -= damage_value
	# health_adjust.emit(health)
	check_death()

func check_death():
	if health <= 0:
		var repair_pack = repair_pack_scene.instantiate()  # Create an instance of the projectile scene
		owner.add_child(repair_pack)  # Add the projectile to the parent node
		
		repair_pack.transform = self.transform  # Set the starting position of the projectile
		
		queue_free()
