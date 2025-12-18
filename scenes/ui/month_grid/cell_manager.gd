@tool
class_name CellManager
extends Node

@export
var cells: Array[CategoryCell] = []

var _highlighted_index := -1

func highlight(index: int) -> CategoryCell:
	if index < 0 or index > cells.size() - 1:
		print("Cannot highlight CategoryCell at invalid index %d!" % index)
		return

	_highlighted_index = index

	for i in cells.size():
		if i == _highlighted_index:
			cells[i].highlight()
		else:
			cells[i].unhighlight()

	return cells[_highlighted_index]

func dim(index: int) -> void:
	for i in cells.size():
		if i == index:
			cells[i].dim()
		else:
			cells[i].undim()

func inject_amount(amount: float) -> void:
	var currency := Strings.curr(amount)

	print("Injecting %s into cell manager" % currency)

	for c in cells:
		if c.is_highlighted():
			print("Injecting %s into cell %s" % [currency, c.name])
			c.inject_amount(amount)

func inject_transactions(transactions: Array[BudgetTransaction]) -> void:
	for i in cells.size():
		var cell := cells[i]

		var transaction_total: float = transactions \
			.filter(func(t: BudgetTransaction): return is_for_category(t, i)) \
			.filter(func(t: BudgetTransaction): return not t.hidden) \
			.map(func(t: BudgetTransaction): return t.amount) \
			.reduce(Math.sum, 0.0)

		# BUG: this method is not called on cells that are created after
		# moving to a new budget section with more categories than the old
		# budget section, so they just say £0.00 instead of the correct amount

		# var cell_path := cell.get_path()
		# var relevant_path := cell_path.slice(-4, cell_path.get_name_count())
		# print("inject_transactions: cell %s" % relevant_path)

		cell.inject_amount(transaction_total)

func is_for_category(transaction: BudgetTransaction, index: int) -> bool:
	return BudgetProvider.get_category_index(transaction.category) == index

func count() -> int:
	return cells.size()

func get_highlighted_category() -> BudgetCategory:
	for i in cells.size():
		if cells[i].is_highlighted():
			return BudgetProvider.get_category(i)

	return null
