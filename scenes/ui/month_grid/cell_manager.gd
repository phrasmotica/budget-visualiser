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

func dim(index: int) -> void:
	for i in cells.size():
		if i == index:
			cells[i].dim()

func inject_amount(amount: float) -> void:
	print("Injecting %.2f into cell manager" % amount)

	for c in cells:
		if c.is_highlighted():
			print("Injecting %.2f into cell %s" % [amount, c.name])
			c.inject_amount(amount)

func inject_transactions(transactions: Array[BudgetTransaction]) -> void:
	for i in cells.size():
		var cell := cells[i]

		var transaction_total: float = transactions \
			.filter(func(t: BudgetTransaction): return is_for_category(t, i)) \
			.map(func(t: BudgetTransaction): return t.amount) \
			.reduce(Math.sum, 0.0)

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
