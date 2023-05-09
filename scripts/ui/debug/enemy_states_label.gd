extends Label3D

func _on_enemy_00_state_changed(states_stack):
	var states_names = ''
	var numbers = ''
	var index = 0
	for state in states_stack:
		states_names += state.get_name() + '\n'
		numbers += str(index) + '\n'
		index += 1
	self.text = states_names
