extends State

var Fsm: StateMachine
var Parent: Player

func _prepare():
	Fsm = get_parent()
	Parent = Fsm.get_parent()

func _on_enter():
	Parent.animationState.travel("Idle")

func _unhandled_input(event):
	if Input.is_action_just_pressed("click"):
		Parent.generate_path(Parent.scene.get_global_mouse_position())
		Fsm.change_state("RunState")




