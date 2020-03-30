extends CanvasLayer

var quitButton: Button

func _ready():
	quitButton = $Button
	quitButton.visible = false
	quitButton.set_disabled(true)

func _input(event):
	if event.is_action_pressed("exit_game"):
		quitButton.visible = !quitButton.visible
		quitButton.set_disabled(false)
		


func _on_Button_pressed():
	get_tree().quit()
