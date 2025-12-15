extends Node

signal entry_cancelled()

func emit_entry_cancelled() -> void:
	entry_cancelled.emit()
