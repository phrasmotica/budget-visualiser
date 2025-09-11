class_name MonthGridManager
extends Node

@export
var month_grids: Array[MonthGrid] = []

var _highlighted_index := -1

signal highlighted_grid_changed(grid: MonthGrid)

func highlight(index: int) -> void:
	_highlighted_index = index

	_refresh()

	# TODO: ensure the index is valid for the list of grids
	highlighted_grid_changed.emit(month_grids[index])

func pause() -> void:
	for i in month_grids.size():
		month_grids[i].unhighlight()

func inject_amount(amount: float) -> void:
	for m in month_grids:
		if m.is_highlighted():
			m.inject_amount(amount)

func _refresh() -> void:
	for i in month_grids.size():
		if i == _highlighted_index:
			month_grids[i].highlight()
		else:
			month_grids[i].unhighlight()

func count() -> int:
	return month_grids.size()
