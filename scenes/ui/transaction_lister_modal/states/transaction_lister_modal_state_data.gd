class_name TransactionListerModalStateData

var _transactions: Array[BudgetTransaction] = []
var _skip_transactions := false

static func build() -> TransactionListerModalStateData:
	return TransactionListerModalStateData.new()

func with_transactions(transactions: Array[BudgetTransaction]) -> TransactionListerModalStateData:
	_transactions = transactions
	return self

func get_transactions() -> Array[BudgetTransaction]:
	return _transactions

func with_skip_transactions() -> TransactionListerModalStateData:
	_skip_transactions = true
	return self

func get_skip_transactions() -> bool:
	return _skip_transactions
