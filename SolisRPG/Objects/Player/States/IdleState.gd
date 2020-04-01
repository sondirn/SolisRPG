extends State

var Fsm: StateMachine
var Parent: Player

func _prepare():
	Fsm = get_parent()
	Parent = Fsm.get_parent()

func _on_enter():
	Parent.animationState.travel("Idle")

func _unhandled_input(event):
	if event.is_action_pressed("click"):
		pass
		#Parent.generate_path(Parent.scene.get_global_mouse_position())
		#Fsm.change_state("RunState")




