class_name MonthGridManager
extends Node

@export
var month_grids: Array[MonthGrid] = []

var _highlighted_index := -1

func highlight(index: int) -> void:
	_highlighted_index = index

	_refresh()

func pause() -> void:
	for i in month_grids.size():
		month_grids[i].unhighlight()

func _refresh() -> void:
	for i in month_grids.size():
		if i == _highlighted_index:
			month_grids[i].highlight()
		else:
			month_grids[i].unhighlight()

func count() -> int:
	return month_grids.size()
