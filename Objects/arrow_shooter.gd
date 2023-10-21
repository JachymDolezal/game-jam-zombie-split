extends Node2D

@onready var arrow = load("res://Objects/arrow.tscn")

var direction : Vector2 = Vector2(0,0)
@onready var animation = $AnimatedSprite2D
@onready var cooldown = $Cooldown
var first = true
var duration_cooldown = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	direction = self.get_meta("Direction")
	duration_cooldown = self.get_meta("Cooldown")
	cooldown.wait_time = duration_cooldown
	cooldown.one_shot = false
	cooldown.start()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if first:
		shoot()
		first = false
	
func shoot():

	var arrow_instance = arrow.instantiate()
	arrow_instance.dir = direction
	arrow_instance.position = self.position + direction * Vector2(10,10)
	arrow_instance.rotation = 275
	get_parent().add_child(arrow_instance)



func _on_cooldown_timeout():
	shoot()
	animation.play("Shoot")
