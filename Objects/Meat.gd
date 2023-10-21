extends Node2D

@onready var animation = $AnimatedSprite2D
@onready var sounds = $AudioStreamPlayer2D
@onready var animationplayer = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#sounds.play()
	pass


func _on_area_2d_body_entered(body):
	if body.name == "Torso" or body.name == "Legs" or body.name == "Zombie":
		Game.points = Game.points + 1
		animationplayer.play("new_animation")
