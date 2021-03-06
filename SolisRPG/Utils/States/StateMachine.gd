extends Node

class_name StateMachine, "res://icon.png"

var Parent: Node
var CurrentState: State
var PreviousState: State
var DEBUG: = true

func _prepare():
	Parent = get_parent()
	var children = get_children()
	if children == null:
		return
	for child in children:
		var state = child as State
		state._prepare()
	CurrentState = get_child(0)
	enter_state()

func enter_state():
	if(DEBUG):
		print("Entering: ", CurrentState.name)
	CurrentState._on_enter()

func change_state(new_state):
	CurrentState._on_exit()
	PreviousState = CurrentState
	CurrentState = get_node(new_state)
	enter_state()

func prevoius_sate():
	CurrentState._on_exit()
	var _currentState: State = CurrentState
	CurrentState = PreviousState
	PreviousState = _currentState
	enter_state()
	
func _process(delta):
	if CurrentState == null:
		return
	CurrentState._update(delta)
	
	
