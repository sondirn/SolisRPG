extends State


var Fsm: StateMachine
var Parent: Node2D

func _prepare():
	Fsm = get_parent()
	Parent = Fsm.get_parent()

func _on_enter():
	var anim : AnimationTree = Parent.get_node("AnimationTree")
	var state : AnimationNodeStateMachinePlayback = anim.get("parameters/playback")
	state.travel("Idle")
	
