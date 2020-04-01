class_name Enemy
extends KinematicBody2D


var speed_modifier: float = 1.0
export var search_range:float
export var health: float
export var max_speed: float

var path:= PoolVector2Array()
var destination:= Vector2() setget set_destination

#nodes
onready var animationPlayer: AnimationPlayer = $AnimationPlayer
onready var animationTree: AnimationTree = $AnimationTree
onready var animationState: AnimationNodeStateMachinePlayback = animationTree.get("parameters/playback")
onready var sprite: Sprite = $Sprite
onready var scene: Node2D = get_tree().root.get_node("Scene")
onready var nav_2d: Navigation2D = scene.get_node("Navigation2D")

var Fsm: StateMachine

func _ready():
	Fsm = get_node("StateMachine") as StateMachine
	Fsm._prepare()


func set_destination(value: Vector2):
	destination = value

