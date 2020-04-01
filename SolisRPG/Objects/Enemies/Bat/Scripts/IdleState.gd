extends State

onready var spawn_point: Vector2

var Fsm: StateMachine
var Parent: Enemy
var kinematic_body: KinematicBody2D

func _prepare():
	Fsm = get_parent()
	Parent = Fsm.get_parent() as Enemy
	kinematic_body = Parent as KinematicBody2D
	spawn_point = kinematic_body.position

func _on_enter():
	generate_destination()

func _update(_delta):
	var move_distance:float = Parent.max_speed * Parent.speed_modifier * _delta
	var starting_point: Vector2 = Parent.position
	var distance_to_destination = starting_point.distance_to(Parent.destination)
	if distance_to_destination == 0:
		return
	if move_distance <= distance_to_destination:
		var move_rotation = Parent.get_angle_to(starting_point.linear_interpolate(Parent.destination, move_distance / distance_to_destination))
		var velocity = Vector2(Parent.max_speed * Parent.speed_modifier, 0).rotated(move_rotation)
		velocity = Parent.move_and_slide(velocity)
	else:
		generate_destination()
		
func generate_destination() -> void:
	#yield(get_tree().create_timer(3.0), "timeout")
	test()
func test() -> void:
	var rand_rotation = rand_range(0, 259)
	var test_dest = Vector2(Parent.search_range, 0).rotated(rand_rotation)
	print(test_dest)
	Parent.destination = spawn_point + test_dest
	
