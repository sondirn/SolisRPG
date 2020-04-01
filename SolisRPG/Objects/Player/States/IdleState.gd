extends State

var Fsm: StateMachine
var Parent: Player

func _prepare():
	Fsm = get_parent()
	Parent = Fsm.get_parent()

func _on_enter():
	Parent.animationState.travel("Idle")

func _update(delta):
	check_for_movement()
	
func check_for_movement() -> void:
	if Input.is_action_pressed("click"):
		Parent.generate_destination()
		Fsm.change_state("RunState")






