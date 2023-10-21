extends Node2D

@onready var anim = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("Idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	if area.name == "Head":
		Game.player_dies = true


func _on_area_2d_body_entered(body):
	if body.name == "Torso":
		Game.player_dies = true
