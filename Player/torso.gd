extends CharacterBody2D


const SPEED = Game.Torso_speed
const JUMP_VELOCITY = Game.Torso_jump_speed
@onready var timer = $Timer
@onready var animation_tree = $AnimationTree
@onready var sounds = $AudioStreamPlayer2D
var push_force = 80
var force = 60

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	animation_tree.active = true
	timer.start()

func _process(delta):
	update_animation_parametrs()


func _physics_process(delta):
	# Add the gravity.
	if Game.player_dies:
		death()

	#if(timer.is_stopped()):
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("U_arrow") and is_on_floor():
		sounds.play()
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if(!timer.is_stopped()):
		pass
	else:
		var direction = Input.get_axis("L_arrow", "R_arrow")
		if direction:
			# flip Sprite2D is the direction is to left
			if direction < 0:
				$AnimatedSprite2D.flip_h = true
			else:
				$AnimatedSprite2D.flip_h = false
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	
	var bodies = get_slide_collision_count()
	for i in range(bodies):
		var collision = get_slide_collision(i)
		if collision.get_collider() is RigidBody2D:
			if collision.get_collider().min_force:
				if force >= int(collision.get_collider().min_force):
					collision.get_collider().apply_impulse(-collision.get_normal() * push_force)
	
func update_animation_parametrs():
	if(velocity == Vector2.ZERO):
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/press_run"] = false
		animation_tree["parameters/conditions/is_falling"] = false
	else:
		animation_tree["parameters/conditions/idle"] = false
	if (velocity.y < 0):
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/press_jump"] = true
		animation_tree["parameters/conditions/press_run"] = false
	if (velocity.y > 0 and !is_on_floor()):
		animation_tree["parameters/conditions/press_jump"] = false
		animation_tree["parameters/conditions/is_falling"] = true
	if (velocity.y == 0 and velocity.x != 0):
		animation_tree["parameters/conditions/is_falling"] = false
		animation_tree["parameters/conditions/press_run"] = true
	else:
		animation_tree["parameters/conditions/press_run"] = false
		

func death():
	# reload the scene
	print("torsi dies")
	Game.player_dies = false
	get_tree().reload_current_scene()
