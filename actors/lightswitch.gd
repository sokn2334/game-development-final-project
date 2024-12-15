extends Node2D
@export var light_1: Node2D
@export var light_2: Node2D
@export var light_3: Node2D
@export var light_4: Node2D
@export var light_5: Node2D
var is_switch_on: bool = false

func _on_button_pressed() -> void:
	if light_1 != null:
		light_1.toggle_light()
	if light_2 != null:
		light_2.toggle_light()
	if light_3 != null:
		light_3.toggle_light()
	if light_4 != null:
		light_4.toggle_light()
	if light_5 != null:
		light_5.toggle_light()
		
	if is_switch_on:
		$SwitchSprite.rotate(-1.3)
		is_switch_on = false
	else:
		$SwitchSprite.rotate(1.3)
		is_switch_on = true
