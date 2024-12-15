extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	var current_scene = get_tree().get_current_scene().get_name()
	if current_scene == "Main":
		call_deferred("change_scene_to_level_1")
	if current_scene == "level1":
		call_deferred("change_scene_to_level_2")
	if current_scene == "level2":
		call_deferred("change_scene_to_level_3")
	if current_scene == "level3":
		GameManager.game_win()

func change_scene_to_level_1():
	get_tree().change_scene_to_file("res://level_1.tscn")

func change_scene_to_level_2():
	get_tree().change_scene_to_file("res://level_2.tscn")

func change_scene_to_level_3():
	get_tree().change_scene_to_file("res://level_3.tscn")
