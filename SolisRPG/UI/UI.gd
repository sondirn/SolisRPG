extends CanvasLayer

onready var quitButton: Button = $Button
onready var background: ColorRect = $BG


func _ready():
	quitButton.visible = false
	background.visible = false
	#quitButton.set_disabled(true)

func _input(event):
	if event.is_action_pressed("exit_game"):
		quitButton.visible = !quitButton.visible
		background.visible = !background.visible
		if quitButton.visible == true:
			get_tree().current_scene.get_tree().paused = true
		else:
			get_tree().current_scene.get_tree().paused = false
		


func _on_Button_pressed():
	get_tree().quit()
