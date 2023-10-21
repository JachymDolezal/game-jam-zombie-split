extends Node2D

@onready var musicplayer = $AudioStreamPlayer2D
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start()
	# hide the Play and Quit buttons
	$Play.hide()
	$Quit.hide()
	

func _process(delta):
	if timer.time_left == 0:
		$Play.show()
		$Quit.show()
	#print(musicplayer.playing)
	if musicplayer.playing == false:
		musicplayer.play()

func _on_play_pressed():
	# start screne
	get_tree().change_scene_to_file("res://Ui/level_selection.tscn")


func _on_quit_pressed():
	# quit game
	get_tree().quit()
