class_name MonthGridManager
extends Node

@export
var month_grids: Array[MonthGrid] = []

func highlight(index: int) -> void:
	for i in month_grids.size():
		if i == index:
			month_grids[i].highlight()
		else:
			month_grids[i].unhighlight()

func count() -> int:
	return month_grids.size()
