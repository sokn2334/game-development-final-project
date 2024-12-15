extends Node2D
@export var SPEED: int = 2
@onready var light = $PointLight2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	light.scale = Vector2(0.1, 0.1)
	var tween = get_tree().create_tween().set_loops(-1)
	tween.tween_property(light, "scale", Vector2(2, 2), SPEED).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(light, "scale", Vector2(0.1, 0.1), SPEED).set_trans(Tween.TRANS_EXPO)
