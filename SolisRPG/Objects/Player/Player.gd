extends KinematicBody2D

export var MAX_SPEED: float = 100;
export var ACCELERATION: float = 1200;
export var FRICTION: float = 1200;
export var GRAVITY: float = 50

var velocity: Vector2 = Vector2.ZERO
var speed_modifier: Vector2 = Vector2.ONE

onready var rayCast: RayCast2D = $Collider/RayCast2D

func _process(delta):
	var input = Vector2.ZERO
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input.y += GRAVITY
	velocity = velocity.move_toward(input * MAX_SPEED, ACCELERATION * delta)
	velocity = move_and_slide(velocity)
