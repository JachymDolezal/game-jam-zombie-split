extends CharacterBody2D


const SPEED = Game.Zombie_speed
const JUMP_VELOCITY = Game.Zombie_jump_speed

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation_tree = $AnimationTree
@onready var sounds = $AudioStreamPlayer2D
var push_force = 80
var force = 80

func _ready():
	animation_tree.active = true

func _process(delta):
	update_animation_parametrs()

func _physics_process(delta):

	if Game.player_dies:
		print(Game.player_dies)
		Game.player_dies = false
		die()

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta


	# Handle Jump.
	if Input.is_action_just_pressed("Up") and is_on_floor():
		sounds.play()
		velocity.y = JUMP_VELOCITY

	if Input.is_action_just_pressed("Transform"):
		transform()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	if direction:
		if is_on_floor():
			pass
		# if flip the sprite if the direction is left
		if direction < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

	# find if colliding with rigidbody
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
		

func transform():
	self.queue_free()
	# instanciate and add two scenes `legs.tscn` and `torso.tscn` not as children
	# but as siblings of the current node
	var legs = load("res://Player/legs.tscn").instantiate()
	var torso = load("res://Player/torso.tscn").instantiate()
	# add it as children of root node
	
	# set the position of the new nodes set it as the current node but legs few pixels up and torso 20 pixels abe legs
	torso.add_collision_exception_with(legs)
	legs.add_collision_exception_with(torso)
	legs.position = position
	torso.position = position + Vector2(0, -20)
	torso.velocity.x = (self.velocity.x) * 1.3
	torso.velocity.y = (self.velocity.y) * 1.3
	legs.velocity.x = (self.velocity.x) * 0.7
	legs.velocity.y = (self.velocity.y) * 0.7
	get_parent().add_child(legs)
	get_parent().add_child(torso)


func die():
	print("zombie dies")
	# go back to the main menu
	get_tree().change_scene_to_file(Game.current_level)
