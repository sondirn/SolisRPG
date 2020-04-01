extends KinematicBody2D

class_name Player

enum{FREE, ATTACK}

export var ACCELERATION: float = 1200
export var FRICTION: float = 1200
export var MAX_SPEED: float = 100

#signal destination_reached
onready var animationPlayer: AnimationPlayer = $AnimationPlayer
onready var animationTree: AnimationTree = $AnimationTree
onready var animationState: AnimationNodeStateMachinePlayback = animationTree.get("parameters/playback")
onready var playerSprite: Sprite = $Sprite
onready var scene: Node2D = get_parent().get_parent()
onready var nav_2d: Navigation2D = scene.get_node("Navigation2D")


var path := PoolVector2Array()
var destination: Vector2 = Vector2.ZERO

var velocity: Vector2

var Fsm: StateMachine

var _speed_modifier: float = 1

func _ready():
	Fsm = get_node("StateMachine")
	Fsm._prepare()
	destination = position
	

func _process(_delta):
	#velocity = Vector2.ZERO
	var move_distance:float = MAX_SPEED * _speed_modifier * _delta
	if Input.is_action_pressed("click"):
		destination = get_global_mouse_position()
	var starting_point : Vector2 = position
	var distance_to_destination = starting_point.distance_to(destination)
	var collision_check = starting_point.direction_to(destination)
	if move_distance <= distance_to_destination:
		var move_rotation = get_angle_to(starting_point.linear_interpolate(destination, move_distance / distance_to_destination))
		var velocity = Vector2(MAX_SPEED * _speed_modifier, 0).rotated(move_rotation)
		var collision = move_and_collide(collision_check * _delta)
		velocity = move_and_slide(velocity)
		if collision != null:
			destination = position
		


func _input(event):
	if Input.is_action_pressed("shift_modifier") && event.is_action_pressed("cast_spell"):
		var fireball = load ("res://Objects/Spells/FireBall.tscn")
		var fireball_instance = fireball.instance()
		fireball_instance.position = position
		fireball_instance.rotation = get_angle_to(get_global_mouse_position())
		get_parent().add_child(fireball_instance)
		fireball_instance = null
		fireball = null


