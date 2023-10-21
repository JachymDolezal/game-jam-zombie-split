extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_button_pressed():
	Game.current_level = "res://demo_level.tscn"
	Game.required_points = 2
	get_tree().change_scene_to_file("res://demo_level.tscn")
	

func _on_button_2_pressed():
	Game.current_level = "res://level_1.tscn"
	Game.required_points = 3
	get_tree().change_scene_to_file("res://level_1.tscn")


func _on_button_3_pressed():
	Game.current_level = "res://level_2.tscn"
	Game.required_points = 5
	get_tree().change_scene_to_file("res://level_2.tscn")


func _on_button_4_pressed():
	Game.current_level = "res://level_3.tscn"
	Game.required_points = 5
	get_tree().change_scene_to_file(Game.current_level)



func _on_button_5_pressed():
	Game.current_level = "res://level_4.tscn"
	Game.required_points = 4
	get_tree().change_scene_to_file(Game.current_level)


func _on_button_10_pressed():
	Game.current_level = "res://level_5.tscn"
	Game.required_points = 4
	get_tree().change_scene_to_file(Game.current_level)
