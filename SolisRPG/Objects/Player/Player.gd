extends KinematicBody2D

class_name Player

enum{FREE, ATTACK}

export var ACCELERATION: float = 1200
export var FRICTION: float = 1200
export var MAX_SPEED: float = 100

signal destination_reached
onready var animationPlayer: AnimationPlayer = $AnimationPlayer
onready var animationTree: AnimationTree = $AnimationTree
onready var animationState: AnimationNodeStateMachinePlayback = animationTree.get("parameters/playback")
onready var playerSprite: Sprite = $Sprite
onready var scene: Node2D = get_parent().get_parent()
onready var nav_2d: Navigation2D = scene.get_node("Navigation2D")


var path := PoolVector2Array()

var velocity: Vector2

var Fsm: StateMachine

var _speed_modifier: float = 1

func _ready():
	Fsm = get_node("StateMachine")
	Fsm._prepare()
	

func _process(_delta):
	velocity = Vector2.ZERO
	var move_distance:float = MAX_SPEED * _speed_modifier * _delta
	
func generate_path(destinationPoint: Vector2):
	if Input.is_action_pressed("click"):
		var closest_destination = nav_2d.get_closest_point(destinationPoint)
		var new_path := nav_2d.get_simple_path(position, closest_destination)
		path = new_path
		

func move_in_path(move_distance: float) -> void:
	var starting_point : Vector2 = position
	for point in range(path.size()):
		var distance_to_next_point = starting_point.distance_to(path[0])
		if move_distance <= distance_to_next_point:
			var move_rotation = get_angle_to(starting_point.linear_interpolate(path[0], move_distance / distance_to_next_point))
			velocity = Vector2(MAX_SPEED * _speed_modifier, 0).rotated(move_rotation)
			move_and_slide(velocity)
			break
		move_distance -= distance_to_next_point
		starting_point = path[0]
		path.remove(0)
	if path.size() == 0:
		emit_signal("destination_reached")

func _input(event):
	if Input.is_action_pressed("shift_modifier") && event.is_action_pressed("click"):
		var fireball = load ("res://Objects/Spells/FireBall.tscn")
		var fireball_instance = fireball.instance()
		fireball_instance.position = position
		get_parent().add_child(fireball_instance)
		fireball_instance = null
		fireball = null
