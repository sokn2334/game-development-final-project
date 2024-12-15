extends Node2D
@onready var light = $PointLight2D
@export var startState = true

func _ready() -> void:
	if startState == true:
		light.enabled = true
	else:
		light.enabled = false

	
func toggle_light():
	if light.enabled == true:
		light.enabled = false
	else:
		light.enabled = true
