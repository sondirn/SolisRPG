extends Node

class_name StateMachine

var DEBUG: bool = true
var Parent = get_parent()
var CurrentState: State
var PreviousState: State 

func _ready():
	var children = get_children()
	for child in children:
		var state: State = child
		state._prepare()
	CurrentState = get_child(0)
	enter_state()

func enter_state():
	if(DEBUG):
		print("Entering: ", CurrentState.name)
	CurrentState._on_enter()

func change_state(new_state):
	PreviousState._on_exit()
	PreviousState = CurrentState
	CurrentState = get_child(new_state)
	enter_state()

func prevoius_sate():
	CurrentState._on_exit()
	var _currentState: State = CurrentState
	CurrentState = PreviousState
	PreviousState = _currentState
	enter_state()
	
	
