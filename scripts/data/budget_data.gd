class_name BudgetData
extends Resource

@export
var all_transactions: Array[BudgetTransaction] = []

func add_transaction(
	category: BudgetCategory,
	month: BudgetMonth,
	amount: float,
) -> BudgetTransaction:
	var transaction := BudgetTransaction.new()

	transaction.category = category
	transaction.month = month
	transaction.amount = amount

	all_transactions.append(transaction)

	return transaction

func compute_category_expenditure(
	category: BudgetCategory,
) -> float:
	var transactions = all_transactions \
		.filter(func(t: BudgetTransaction): return t.category == category)

	return _add_amounts(transactions)

func compute_month_expenditure(
	month: BudgetMonth,
) -> float:
	var transactions = all_transactions \
		.filter(func(t: BudgetTransaction): return t.month == month)

	return _add_amounts(transactions)

func compute_total_expenditure() -> float:
	return _add_amounts(all_transactions)

func _add_amounts(transactions: Array[BudgetTransaction]) -> float:
	return transactions \
		.map(func(t: BudgetTransaction): return t.amount) \
		.reduce(Math.sum, 0.0)
