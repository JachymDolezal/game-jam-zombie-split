extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Game.points = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Game.points == Game.required_points:
		get_tree().change_scene_to_file("res://level_selection.tscn")
