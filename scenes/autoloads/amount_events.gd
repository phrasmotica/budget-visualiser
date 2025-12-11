extends Node

signal entry_cancelled()
signal entry_finished(amount: float)

func emit_entry_cancelled() -> void:
	entry_cancelled.emit()

func emit_entry_finished(amount: float) -> void:
	entry_finished.emit(amount)
