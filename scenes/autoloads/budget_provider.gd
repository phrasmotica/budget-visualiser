extends Node

var _data: BudgetData = null

signal transaction_added(transaction: BudgetTransaction)

func set_budget_data(data: BudgetData) -> void:
	_data = data

func add_transaction(
	category: BudgetCategory,
	month: BudgetMonth,
	amount: float,
) -> void:
	var new_transaction = _data.add_transaction(category, month, amount)
	transaction_added.emit(new_transaction)
