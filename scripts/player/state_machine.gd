extends CharacterBody3D

signal state_changed
signal health_adjust(health_value)
signal game_over

var states_stack = []
var current_state = null
var lock_on_target

@export var max_health:= 20

@onready var health = max_health
@onready var invincible := false

@onready var torso = get_node("Torso/Guns")
@onready var primary_gun_1 = torso.get_node("PrimarySlot1/PrimaryGun")
@onready var primary_gun_2 = torso.get_node("PrimarySlot2/PrimaryGun")
@onready var secondary_gun_1 = torso.get_node("SecondarySlot1/SecondaryGun")
@onready var secondary_gun_2 = torso.get_node("SecondarySlot2/SecondaryGun")

@onready var raycast: RayCast3D = torso.get_node("LockOnRayCast")

@onready var states_map = {
	"idle": $States/Idle,
	"move": $States/Move,
}

func _ready():
	for state_node in $States.get_children():
		state_node.finished.connect(_change_state)
	states_stack.push_front($States/Idle)
	current_state = states_stack[0]
	_change_state("idle")
	health_adjust.emit(health)

func _physics_process(delta):
	current_state.update(delta)
	if raycast.get_collider() != null:
		# print(raycast.get_collider())
		lock_on_target = raycast.get_collider()
	
	# if lock_on_target != null:
	# 	print(lock_on_target.global_position)

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

func take_damage(damage_value):
	if invincible:
		return
	health -= damage_value
	health_adjust.emit(health)
	check_death()

func take_heal(heal_value):
	health += heal_value
	health_adjust.emit(health)
	
func check_death():
	if health <= 0:
		game_over.emit()
