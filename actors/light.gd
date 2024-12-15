extends RigidBody2D

var dragging = false
var of = Vector2(0,0)
static var RADIUS = 90
@onready var anchor_point = get_parent()
var target_position = Vector2(0,0)

func _physics_process(delta: float) -> void:
	if (dragging):
		apply_central_force(global_position.direction_to(get_global_mouse_position()) * 2000)
func _on_button_button_down() -> void:
	if not $"../Chain".playing:
			$"../Chain".play()
	dragging = true

func _on_button_button_up() -> void:
	dragging = false
