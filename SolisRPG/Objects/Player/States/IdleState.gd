extends State

var Fsm: StateMachine
var Parent: Player

func _prepare():
	Fsm = get_parent()
	Parent = Fsm.get_parent()

func _on_enter():
	Parent.animationState.travel("Idle")

func _update(delta):
	Parent.velocity = Parent.velocity.move_toward(Vector2.ZERO, Parent.FRICTION * delta)
	check_for_movement()

func check_for_movement():
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	if input_vector != Vector2.ZERO:
		Fsm.change_state("RunState")

