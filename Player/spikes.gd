extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.name == "Torso" or body.name == "Legs" or body.name == "Zombie":
		# restart the scene
		print(get_tree())
		get_tree().reload_current_scene()
