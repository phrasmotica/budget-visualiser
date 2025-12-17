extends Node

signal cancelled

func emit_cancelled() -> void:
	cancelled.emit()
