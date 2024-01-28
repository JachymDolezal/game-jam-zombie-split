extends RigidBody2D

@export var max_speed = 100.0

@export var min_force = 78

func _ready():
	min_force = self.get_meta("MinForce")


func _integrate_forces(force):
	# print current force
	# print("velocity vector",force.linear_velocity,"center_of_mass",force.center_of_mass)
	# velocity is lower than minimum speed limit -> set to zero
	if force.linear_velocity.length()>max_speed:
		force.linear_velocity=force.linear_velocity.normalized()*max_speed
