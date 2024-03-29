extends Node2D
@onready var pause_menu = load("res://Ui/Menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_pressed():
	get_tree().change_scene_to_file("res://Ui/main_menu.tscn")

func _on_button_pressed():
	Game.points = 0
	Game.current_level = "res://Levels/demo_level.tscn"
	Game.required_points = 2
	get_tree().change_scene_to_file(Game.current_level)
	# add pause menu node to the scene as child
	var menu = pause_menu.instantiate()
	# add pause menu node to the scene as child
	add_child(menu)

func _on_button_2_pressed():
	Game.points = 0
	Game.current_level = "res://Levels/level_1.tscn"
	Game.required_points = 3
	get_tree().change_scene_to_file(Game.current_level)


func _on_button_3_pressed():
	Game.points = 0
	Game.current_level = "res://Levels/level_2.tscn"
	Game.required_points = 5
	get_tree().change_scene_to_file(Game.current_level)


func _on_button_4_pressed():
	Game.points = 0
	Game.current_level = "res://Levels/level_3.tscn"
	Game.required_points = 6
	get_tree().change_scene_to_file(Game.current_level)



func _on_button_5_pressed():
	Game.points = 0
	Game.current_level = "res://Levels/level_4.tscn"
	Game.required_points = 4
	get_tree().change_scene_to_file(Game.current_level)


func _on_button_10_pressed():
	Game.points = 0
	Game.current_level = "res://Levels/level_5.tscn"
	Game.required_points = 5
	get_tree().change_scene_to_file(Game.current_level)


func _on_button_11_pressed():
	Game.points = 0
	Game.current_level = "res://Levels/level_6.tscn"
	Game.required_points = 3
	get_tree().change_scene_to_file(Game.current_level)
