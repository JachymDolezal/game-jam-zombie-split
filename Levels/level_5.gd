extends Node2D


@onready var sounds = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	Game.points = 0
	sounds.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(Game.points)
	if Game.points == Game.required_points:
		get_tree().change_scene_to_file("res://Ui/level_selection.tscn")
