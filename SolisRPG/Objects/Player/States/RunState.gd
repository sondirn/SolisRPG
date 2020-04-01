extends State

var Parent: Player
var Fsm: StateMachine

var TRUE_MAX_SPEED: float

func _prepare():
	Fsm = get_parent()
	Parent = Fsm.get_parent()

func _on_enter():
	#Parent.animationState.travel("Run")
	pass
func _on_exit():
	pass
	
func _update(delta):
	var move_distance:float = Parent.MAX_SPEED * Parent._speed_modifier * delta
	var starting_point: Vector2 = Parent.position
	var distance_to_destination = starting_point.distance_to(Parent.destination)
	if distance_to_destination == 0:
		Fsm.change_state("IdleState")
		return
	var collision_check := starting_point.direction_to(Parent.destination)
	if move_distance <= distance_to_destination:
		var move_rotation = Parent.get_angle_to(starting_point.linear_interpolate(Parent.destination, move_distance / distance_to_destination))
		var velocity = Vector2(Parent.MAX_SPEED * Parent._speed_modifier, 0).rotated(move_rotation)
		var player_as_kinematic = Parent as KinematicBody2D
		collision_check = collision_check.normalized()
		var collision_detect = player_as_kinematic.move_and_collide(velocity * delta, true, true, true)
		if collision_detect != null:
			Fsm.change_state("IdleState")
			Parent.destination = player_as_kinematic.position
			return
		elif collision_detect == null:
			velocity = player_as_kinematic.move_and_slide(velocity)
			Parent.animationTree.set("parameters/Idle/blend_position", collision_check)
			Parent.animationTree.set("parameters/Run/blend_position", collision_check)
		if Input.is_action_pressed("click"):
			Parent.generate_destination()
		Parent.animationState.travel("Run")
			
	else:
		Fsm.change_state("IdleState")

