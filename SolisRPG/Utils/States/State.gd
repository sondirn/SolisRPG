extends Node

class_name State

var _hasEntered: bool = false

func _prepare():
	pass

func _on_enter():
	_hasEntered = true

func _on_exit():
	_hasEntered = false

func _update(_delta):
	pass

func _physics_update(_delta):
	pass


