extends Node2D




func _on_Button_pressed():
	$CanvasLayer/Button.hide()
	background_load.load_scene("res://Scenes/SandBox.tscn")
