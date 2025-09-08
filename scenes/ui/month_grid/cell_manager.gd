class_name CellManager
extends Node

@export
var cells: Array[CategoryCell] = []

func count() -> int:
	return cells.size()
