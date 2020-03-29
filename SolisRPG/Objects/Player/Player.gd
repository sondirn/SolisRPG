extends KinematicBody2D

class_name Player

export var ACCELERATION: float = 1200
export var FRICTION: float = 1200
export var MAX_SPEED: float = 100

var velocity: Vector2

#var animationPlayer: AnimationPlayer
#var animationTree : AnimationTree
#var animationState: AnimationNodeStateMachinePlayback

var Fsm: StateMachine

var _speed_modifier: float = 1

func _ready():
	#animationPlayer = $AnimationPlayer
	#animationTree = $AnimationTree
	#animationState = animationTree.get("parameters/playback")
	Fsm = get_node("StateMachine")
	Fsm._prepare()

func _process(_delta):
	_speed_modifier = Math.Clamp(_speed_modifier, 0 , 1)
	velocity = move_and_slide(velocity)
