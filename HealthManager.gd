extends Node

signal in_sun
signal not_in_sun
var current_health: int

func player_in_sun():
	in_sun.emit()

func player_not_in_sun():
	not_in_sun.emit()

func set_health(num:int):
	current_health = num

func get_health() -> int:
	return current_health
