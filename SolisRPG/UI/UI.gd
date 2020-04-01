extends CanvasLayer

onready var quitButton: Button = $Button
onready var background: ColorRect = $BG


func _ready():
	quitButton.visible = false
	background.visible = false
	quitButton.set_disabled(true)

func _input(event):
	if event.is_action_pressed("exit_game"):
		quitButton.visible = !quitButton.visible
		background.visible = !background.visible
		quitButton.set_disabled(false)
		


func _on_Button_pressed():
	get_tree().quit()
