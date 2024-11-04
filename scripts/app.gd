extends Node2D

signal app_open
signal app_quit

func _ready():
	app_open.emit()

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		app_quit.emit()

		get_tree().quit()
