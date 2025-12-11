class_name RecentTransactions
extends VBoxContainer

@export
var category: BudgetCategory

@export
var month: BudgetMonth

@export
var visible_count := 5

@onready
var none_label: Label = %NoneLabel

@onready
var ledger: VBoxContainer = %Ledger

@onready
var transactions_label: Label = %TransactionsLabel

@onready
var more_section: VBoxContainer = %MoreSection

@onready
var more_label: Label = %MoreLabel

@onready
var total_label: Label = %TotalLabel

func _ready() -> void:
	reload()

func reload() -> void:
	var transactions := _get_transactions()
	var has_transactions := transactions.size() > 0

	none_label.visible = not has_transactions
	ledger.visible = has_transactions

	transactions_label.text = _compute_transactions_text(transactions)

	var more_count := maxi(0, transactions.size() - visible_count)
	more_label.text = "+%d more" % more_count

	more_section.visible = more_count > 0

	var total_amount: float = transactions \
		.map(func(t: BudgetTransaction): return t.amount) \
		.reduce(Math.sum, 0.0)

	total_label.text = "%.2f" % total_amount

func _get_transactions() -> Array[BudgetTransaction]:
	var budget_data := BudgetProvider.get_budget_data()
	if not budget_data:
		return []

	return budget_data.get_transactions_for_category_and_month(category, month)

func _compute_transactions_text(transactions: Array[BudgetTransaction]) -> String:
	if transactions.size() <= 0:
		return ""

	var recent_transactions := transactions.slice(0)
	recent_transactions.reverse()

	return recent_transactions \
		.slice(0, visible_count) \
		.map(func(t: BudgetTransaction): return t.amount) \
		.map(func(f: float): return "%.2f" % f) \
		.reduce(Strings.join("\n"))
