extends Area2D


export var target_scene: String 




func _on_SceneTransition_body_entered(body):
	if body.is_in_group("player"):
		background_load.load_scene(target_scene)
