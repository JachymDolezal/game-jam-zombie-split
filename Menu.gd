extends Control


func _on_restart_level_pressed():
	# restart load scene from Game.current_level
	get_tree().change_scene_to_file(Game.current_level)


func _on_select_level_pressed():
	get_tree().change_scene_to_file("res://level_selection.tscn")


func _on_quit_pressed():
	get_tree().quit()
