extends RigidBody2D


var projectile_speed = 400

func _ready():
	apply_impulse(Vector2(), Vector2(projectile_speed, 0).rotated(rotation))
