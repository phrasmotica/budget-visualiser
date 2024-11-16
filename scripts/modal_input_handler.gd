extends Node

signal cancelled

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		return

	handle_input()

func handle_input():
	if Input.is_action_just_pressed("ui_cancel"):
		cancelled.emit()
