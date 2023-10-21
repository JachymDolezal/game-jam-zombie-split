extends CharacterBody2D


const SPEED = Game.Legs_speed
const JUMP_VELOCITY = Game.Legs_jump_speed
var can_transform_back = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation_tree = $AnimationTree
@onready var sounds = $AudioStreamPlayer2D

func _ready():
	animation_tree.active = true

func _process(delta):
	update_animation_parametrs()

func _physics_process(delta):

	if Game.player_dies:
		death()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("Up") and is_on_floor():
		sounds.play()
		velocity.y = JUMP_VELOCITY

	if (Input.is_action_pressed("Transform")) and can_transform_back:
		transform_to_normal()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
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


func _on_area_2d_body_entered(body):
	if body.name == 'Torso':
		can_transform_back = true


func _on_area_2d_body_exited(body):
	if body.name == 'Torso':
		can_transform_back = false

func transform_to_normal():
	# get torso and remove it
	var torso = get_parent().get_node("Torso")
	
	# instanciate normal body
	var normal_body = preload("res://Player/zombie.tscn").instantiate()
	get_parent().add_child(normal_body)
	# set position
	normal_body.position = self.position
	torso.queue_free()
	# remove self
	self.queue_free()
	
func update_animation_parametrs():
	if(velocity == Vector2.ZERO):
		animation_tree["parameters/conditions/Idle"] = true
		animation_tree["parameters/conditions/Press Run"] = false
		animation_tree["parameters/conditions/Is Falling"] = false
	else:
		animation_tree["parameters/conditions/Idle"] = false
	if (velocity.y < 0):
		animation_tree["parameters/conditions/Idle"] = false
		animation_tree["parameters/conditions/Press Jump"] = true
		animation_tree["parameters/conditions/Press Run"] = false
	if (velocity.y > 0 and !is_on_floor()):
		animation_tree["parameters/conditions/Press Jump"] = false
		animation_tree["parameters/conditions/Is Falling"] = true
	if (velocity.y == 0 and velocity.x != 0):
		animation_tree["parameters/conditions/Is Falling"] = false
		animation_tree["parameters/conditions/Press Run"] = true
	else:
		animation_tree["parameters/conditions/Press Run"] = false

func death():
	# reload scene
	Game.player_dies = false
	get_tree().reload_current_scene()
