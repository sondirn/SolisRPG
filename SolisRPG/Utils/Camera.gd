extends Camera2D

export var cameraZoom:float = 1
export var camera_smooth: float = 7

func _ready():
	zoom = Vector2(cameraZoom, cameraZoom)
	
	
func _input(event):
	if event.is_action_pressed("zoom_in"):
		cameraZoom -= 0.05
		zoom = Vector2(cameraZoom, cameraZoom)
		if OS.is_debug_build():
			print("camera zoom: ", cameraZoom)
	if event.is_action_pressed("zoom_out"):
		cameraZoom += 0.05
		zoom = Vector2(cameraZoom, cameraZoom)
		if OS.is_debug_build():
			print("camera zoom: ", cameraZoom)
	
