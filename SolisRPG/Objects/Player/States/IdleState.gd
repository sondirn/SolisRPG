extends State
#PLAYER IDLE STATE 
var Fsm: StateMachine
var Parent: Player

func _prepare():
	Fsm = get_parent()
	Parent = Fsm.get_parent()

func _on_enter():
	Parent.animationState.travel("Idle")
	set_process_unhandled_input(true)
func _on_exit():
	set_process_unhandled_input(false)

func _update(_delta):
	pass#check_for_movement()
	
func _unhandled_input(_event) -> void:
	if Input.is_action_pressed("click"):
		Parent.generate_destination()
		Fsm.change_state("RunState")






