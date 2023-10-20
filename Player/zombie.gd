extends CharacterBody2D


const SPEED = Game.Zombie_speed
const JUMP_VELOCITY = Game.Zombie_jump_speed

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation_tree = $AnimationTree

func _ready():
	animation_tree.active = true

func _process(delta):
	update_animation_parametrs()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("Up") and is_on_floor():
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
	get_parent().add_child(legs)
	get_parent().add_child(torso)
	# set the position of the new nodes set it as the current node but legs few pixels up and torso 20 pixels abe legs
	legs.position = position
	torso.position = position + Vector2(0, -20)
	torso.velocity.x = (self.velocity.x) * 1.3
	torso.velocity.y = (self.velocity.y) * 1.3
	torso.add_collision_exception_with(legs)
	legs.add_collision_exception_with(torso)
