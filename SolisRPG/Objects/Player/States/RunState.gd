extends State

var Parent: Player
var Fsm: StateMachine

func _prepare():
	Fsm = get_parent()
	Parent = Fsm.get_parent()

func _on_enter():
	Parent.animationState.travel("Run")

func _update(delta):
	var TRUE_MAX_SPEED = Parent.MAX_SPEED * Parent._speed_modifier
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	
	if input_vector.x < 0:
		Parent.playerSprite.flip_h = true
	elif input_vector.x > 0:
		Parent.playerSprite.flip_h = false
	elif input_vector.y != 0 && input_vector.x == 0:
		Parent.playerSprite.flip_h = false
	
	if input_vector == Vector2.ZERO:
		Fsm.change_state("IdleState")
		return
	
	
	Parent.animationTree.set("parameters/Idle/blend_position", input_vector)
	Parent.animationTree.set("parameters/Run/blend_position", input_vector)
	input_vector = input_vector.normalized()
	Parent.velocity = Parent.velocity.move_toward(input_vector * TRUE_MAX_SPEED, Parent.ACCELERATION * delta)
	

