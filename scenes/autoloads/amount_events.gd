extends Node

signal entry_finished(amount: float)

func emit_entry_finished(amount: float) -> void:
	entry_finished.emit(amount)
