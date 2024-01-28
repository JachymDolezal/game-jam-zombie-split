extends Node2D

var dir : Vector2 = Vector2(0,0)
var velocity = 90
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print("direction",dir)
	# move in direction of dir
	self.position += dir * velocity * delta



func _on_area_2d_body_entered(body):
	
	if body.name == "Legs" or body.name == "Zombie" or body.name == "Torso":
		Game.player_dies = true
	queue_free()
