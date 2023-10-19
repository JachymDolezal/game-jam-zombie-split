extends CharacterBody2D


const SPEED = Game.Zombie_speed
const JUMP_VELOCITY = Game.Zombie_jump_speed

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var Anim = $AnimatedSprite2D


func transform():
	print("transform")
	self.queue_free()
	print("spawn")
	# instanciate and add two scenes `legs.tscn` and `torso.tscn` not as children
	# but as siblings of the current node
	var legs = load("res://Player/legs.tscn").instantiate()
	var torso = load("res://Player/torso.tscn").instantiate()
	# add it as children of root node
	get_parent().add_child(legs)
	get_parent().add_child(torso)
	# set the position of the new nodes set it as the current node but legs few pixels up and torso 20 pixels abe legs
	legs.position = position
	torso.position = position + Vector2(0, -20)
	print(self.velocity)
	torso.velocity.x = self.velocity.x
	torso.velocity.x = self.velocity.y
	torso.add_collision_exception_with(legs)
	legs.add_collision_exception_with(torso)
	# set the velocity of current node to the new nodes
	# legs.velocity = velocity
	
	#legs.set_as_toplevel(true)
	#torso.set_as_toplevel(true)
	# set the current node as the torso

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("Up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		Anim.stop()
		Anim.play("Jump")

	if Input.is_action_just_pressed("Transform"):
		transform()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	if direction:
		if is_on_floor():
			Anim.play("Run")
		# if flip the sprite if the direction is left
		if direction < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
		velocity.x = direction * SPEED
	else:
		if is_on_floor():
			Anim.play("Idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
