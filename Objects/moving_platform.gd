extends Node2D

var is_horizontal = true
var platform_speed = 10
var platform_distance = 50
@onready var wait_timer = $WaitTimer
var is_forward = true
# Called when the node enters the scene tree for the first time.
func _ready():
	# load meta data
	is_horizontal = bool(self.get_meta("IsHorizontal"))
	platform_speed = float(self.get_meta("PlatformSpeed"))
	platform_distance = int(self.get_meta("PlatformDistance"))
	wait_timer.wait_time = float(self.get_meta("WaitTime"))
	wait_timer.one_shot = true
	# set initial direction
	is_forward = bool(self.get_meta("IsForward"))
	if not is_forward:
		platform_speed *= -1



var is_waiting = false

func _process(delta):
	if is_waiting:
		return

	if is_horizontal:
		self.position.x += platform_speed
		if self.position.x > platform_distance or self.position.x < -platform_distance:
			wait_timer.start()
			is_waiting = true
			platform_speed *= -1
	else:
		self.position.y += platform_speed
		if self.position.y > platform_distance or self.position.y < -platform_distance:
			wait_timer.start()
			is_waiting = true
			platform_speed *= -1

func _on_wait_timer_timeout():
	is_waiting = false
	wait_timer.stop()
