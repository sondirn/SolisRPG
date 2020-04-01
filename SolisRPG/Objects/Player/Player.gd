class_name Player
extends KinematicBody2D


enum{FREE, ATTACK}

export var ACCELERATION: float = 1200
export var FRICTION: float = 1200
export var MAX_SPEED: float = 100

#signal destination_reached
onready var animationPlayer: AnimationPlayer = $AnimationPlayer
onready var animationTree: AnimationTree = $AnimationTree
onready var animationState: AnimationNodeStateMachinePlayback = animationTree.get("parameters/playback")
onready var playerSprite: Sprite = $Sprite
onready var scene: Node2D = get_tree().root.get_node("Scene")
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
	set_process(false)
	
func generate_destination() -> void:
	destination = nav_2d.get_closest_point(get_global_mouse_position())
	pass


func _input(event):
	if Input.is_action_pressed("shift_modifier") && event.is_action_pressed("cast_spell"):
		var fireball = load ("res://Objects/Spells/FireBall.tscn")
		var fireball_instance = fireball.instance()
		fireball_instance.position = position
		fireball_instance.rotation = get_angle_to(get_global_mouse_position())
		get_parent().add_child(fireball_instance)
		fireball_instance = null
		fireball = null


