extends KinematicBody2D

class_name Player

export var ACCELERATION: float = 1200
export var FRICTION: float = 1200
export var MAX_SPEED: float = 100


onready var animationPlayer: AnimationPlayer = $AnimationPlayer
onready var animationTree: AnimationTree = $AnimationTree
onready var animationState: AnimationNodeStateMachinePlayback = animationTree.get("parameters/playback")
onready var playerSprite: Sprite = $Sprite

var velocity: Vector2

var Fsm: StateMachine

var _speed_modifier: float = 1

func _ready():
	Fsm = get_node("StateMachine")
	Fsm._prepare()

func _process(_delta):
	_speed_modifier = Math.Clamp(_speed_modifier, 0 , 1)
	velocity = move_and_slide(velocity)

func _input(event):
	if event.is_action_pressed("exit_game"):
		get_tree().quit()
