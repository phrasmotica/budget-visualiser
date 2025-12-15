class_name TransactionListerModalStateData

var _transactions: Array[BudgetTransaction] = []

static func build() -> TransactionListerModalStateData:
	return TransactionListerModalStateData.new()

func with_transactions(transactions: Array[BudgetTransaction]) -> TransactionListerModalStateData:
	_transactions = transactions
	return self

func get_transactions() -> Array[BudgetTransaction]:
	return _transactions
