class_name CellManager
extends Node

@export
var cells: Array[CategoryCell] = []

func highlight(index: int) -> void:
	for i in cells.size():
		if i == index:
			cells[i].highlight()
		else:
			cells[i].unhighlight()

func count() -> int:
	return cells.size()
