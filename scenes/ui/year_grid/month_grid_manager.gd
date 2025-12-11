@tool
class_name MonthGridManager
extends Node

@export
var headers_parent: HBoxContainer

@export
var grid_parent: HBoxContainer

@export
var month_grids: Array[MonthGrid] = []:
	set(value):
		month_grids = value

var _highlighted_index := -1

signal highlighted_grid_changed(grid: MonthGrid)

func refresh_headers(label_owner: Control, months: Array[BudgetMonth]) -> void:
	var month_count := months.size()
	var child_count := headers_parent.get_child_count()

	for i in month_count:
		var label: Label

		if i >= child_count:
			label = MonthGridFactory.create_label(i)

			headers_parent.add_child(label)
			label.owner = label_owner
		else:
			label = headers_parent.get_child(i)

		var new_text := "<Month%d>" % i

		var month := months[i]
		if month:
			new_text = month.name

		label.text = new_text

	while headers_parent.get_child_count() > month_count:
		var child := headers_parent.get_child(month_count)
		headers_parent.remove_child(child)

func refresh_grids(grid_owner: Control, months: Array[BudgetMonth]) -> void:
	var month_count := months.size()
	var child_count := grid_parent.get_child_count()

	month_grids.clear()

	for i in month_count:
		var grid: MonthGrid

		if i >= child_count:
			grid = MonthGridFactory.create_grid(i)

			grid_parent.add_child(grid)
			grid.owner = grid_owner
		else:
			grid = grid_parent.get_child(i)

		grid.month = months[i]

		month_grids.append(grid)

	while grid_parent.get_child_count() > month_count:
		var child := grid_parent.get_child(month_count)
		grid_parent.remove_child(child)

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
