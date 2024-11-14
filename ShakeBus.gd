extends Node

signal shake_triggered()

func trigger_shake():
	shake_triggered.emit()
