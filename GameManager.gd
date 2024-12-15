extends Node

signal game_start
signal game_over
signal game_over_screen_on
signal win

var death_count:float = 1

func game_started():
	game_start.emit()

func game_ended():
	game_over.emit()
	death_count += 1
	
func get_death_count() -> int:
	return death_count

func game_over_screen_is_on():
	game_over_screen_on.emit()
	
func game_win():
	win.emit()
