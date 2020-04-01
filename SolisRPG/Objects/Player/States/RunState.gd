extends State

var Parent: Player
var Fsm: StateMachine

var TRUE_MAX_SPEED: float

func _prepare():
	Fsm = get_parent()
	Parent = Fsm.get_parent()

func _on_enter():
	Parent.animationState.travel("Run")
	
func _on_exit():
	pass
	
func _update(delta):
	TRUE_MAX_SPEED = Parent.MAX_SPEED * Parent._speed_modifier * delta
	Parent.move_in_path(TRUE_MAX_SPEED)
	if Parent.path.size() == 0:
		return
	var normalizedDir = Parent.velocity.normalized()
	Parent.animationTree.set("parameters/Idle/blend_position", normalizedDir)
	Parent.animationTree.set("parameters/Run/blend_position", normalizedDir)


func _unhandled_input(event):
	if event.is_action("click"):
		pass
		#Parent.generate_path(Parent.scene.get_global_mouse_position())


func _on_Player_destination_reached():
	Fsm.change_state("IdleState")
