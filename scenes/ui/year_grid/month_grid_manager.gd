class_name MonthGridManager
extends Node

@export
var month_grids: Array[MonthGrid] = []

var _highlighted_index := -1

signal highlighted_grid_changed(grid: MonthGrid)

func highlight(index: int) -> MonthGrid:
	if index < 0 or index > month_grids.size() - 1:
		print("Cannot highlight MonthGrid at invalid index %d!" % index)
		return

	_highlighted_index = index

	for i in month_grids.size():
		month_grids[i].enable()

		if i == _highlighted_index:
			month_grids[i].highlight()
		else:
			month_grids[i].unhighlight()

	highlighted_grid_changed.emit(month_grids[index])

	return month_grids[index]

func pause() -> void:
	for i in month_grids.size():
		month_grids[i].unhighlight()
		month_grids[i].disable()

func inject_amount(amount: float) -> void:
	for m in month_grids:
		if m.is_highlighted():
			m.inject_amount(amount)

func inject_budget(data: BudgetData) -> void:
	for m in month_grids:
		m.inject_budget(data)

func count() -> int:
	return month_grids.size()

func get_highlighted_category() -> BudgetCategory:
	for m in month_grids:
		if m.is_highlighted():
			return m.get_highlighted_category()

	return null

func get_highlighted_month() -> BudgetMonth:
	for m in month_grids:
		if m.is_highlighted():
			return m.month

	return null
