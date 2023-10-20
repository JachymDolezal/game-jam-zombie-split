extends Node2D

@onready var animation = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_area_2d_body_entered(body):
	Game.points = Game.points + 1
	self.queue_free()
