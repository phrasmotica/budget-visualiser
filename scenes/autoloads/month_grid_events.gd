extends Node

signal cell_highlighted(cell: CategoryCell, is_up: bool)

func emit_cell_highlighted(cell: CategoryCell, is_up: bool) -> void:
	cell_highlighted.emit(cell, is_up)
