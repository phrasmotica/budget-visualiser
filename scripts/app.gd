extends Node2D

signal app_open
signal app_ready
signal app_quit

func _ready():
	app_open.emit()
	app_ready.emit()

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		app_quit.emit()

		get_tree().quit()
