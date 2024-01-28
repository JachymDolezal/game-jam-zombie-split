extends CharacterBody2D


const SPEED = 90
var direction = -1
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta


	if direction:
		velocity.x = direction * SPEED

	# if it hits a wall, turn around
	if is_on_wall():
		direction = -direction
		position.x = position.x + (direction * 3)

	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.name == "Legs" or body.name == "Zombie" or body.name == "Torso":
		Game.player_dies = true

