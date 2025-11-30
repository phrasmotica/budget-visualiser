class_name BudgetData
extends Resource

@export
var transactions: Array[BudgetTransaction] = []

func add_transaction(
	category: BudgetCategory,
	month: BudgetMonth,
	amount: float,
) -> BudgetTransaction:
	var transaction := BudgetTransaction.new()

	transaction.category = category
	transaction.month = month
	transaction.amount = amount

	transactions.append(transaction)

	return transaction
