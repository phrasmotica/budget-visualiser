class_name RecentTransactions
extends VBoxContainer

@export
var category: BudgetCategory

@export
var month: BudgetMonth

@export
var visible_count := 5

@onready
var transactions_label: Label = %TransactionsLabel

@onready
var more_label: Label = %MoreLabel

func _ready() -> void:
	reload()

func reload() -> void:
	var transactions := _get_transactions()
	transactions_label.text = _compute_transactions_text(transactions)

	var more_count := maxi(0, transactions.size() - visible_count)
	more_label.visible = more_count > 0
	more_label.text = "+%d more" % more_count

func _get_transactions() -> Array[BudgetTransaction]:
	var budget_data := BudgetProvider.get_budget_data()
	if not budget_data:
		return []

	return budget_data.get_transactions_for_category_and_month(category, month)

func _compute_transactions_text(transactions: Array[BudgetTransaction]) -> String:
	if transactions.size() <= 0:
		return ""

	return transactions \
		.slice(0, visible_count) \
		.map(func(t: BudgetTransaction): return t.amount) \
		.map(func(f: float): return "%.2f" % f) \
		.reduce(Strings.join("\n"))
