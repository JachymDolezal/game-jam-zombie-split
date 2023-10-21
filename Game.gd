extends Node

#@onready var pause_menu = load("res://Menu.tscn")
var paused = false

const arrow_shooter_cooldown = 1.0

const Zombie_speed = 90.0
const Zombie_jump_speed = -250
const Zombie_weight = 3

const Legs_speed = 130
const Legs_jump_speed = -300
const Legs_weight = 1

const Torso_speed = 80
const Torso_jump_speed = -190
const Torso_weight = 2

var points = 0
var required_points = 0


# player death handling
var current_level = ""
var player_dies = false


func _process(delta):

	if Input.is_action_just_pressed("Menu"):
		pauseMenu()


func pauseMenu():
	# if the current scene is main menu or level select, then don't pause
	if get_tree().get_current_scene().get_name() == "MainMenu" or get_tree().get_current_scene().get_name() == "LevelSelection":
		return
	get_tree().change_scene_to_file("res://Ui/PauseMenu.tscn")
