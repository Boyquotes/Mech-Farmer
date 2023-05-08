extends ColorRect

func _on_Game_Over():
	self.visible = true

func _on_button_pressed():
	get_tree().change_scene_to_file("res://levels/debug.tscn")


func _on_player_game_over():
	self.visible = true
