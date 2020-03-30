extends Node

onready var sprite: Sprite = $Sprite

var objectIsInside:bool = false
var fading: bool = false
var alpha: float = 1
export var fadeSpeed: float = 4
export var minimumFade: float = 0.35

func _ready():
	set_process(false)

func _process(delta):
	if objectIsInside && fading:
		alpha -= delta*fadeSpeed
		sprite.modulate = Color(1,1,1,alpha)
		if alpha <= minimumFade:
			fading = false
			set_process(false)
	
	if !objectIsInside && fading:
		alpha += delta*fadeSpeed
		sprite.modulate = Color(1,1,1,alpha)
		if alpha >= 1:
			fading = false
			set_process(false)
	


func _on_AlphaCollider_body_entered(body):
	if body.is_in_group("moving_entity"):
		set_process(true)
		objectIsInside = true
		fading = true


func _on_AlphaCollider_body_exited(body):
	if body.is_in_group("moving_entity"):
		set_process(true)
		objectIsInside = false
		fading = true
