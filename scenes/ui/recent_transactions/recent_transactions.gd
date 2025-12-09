class_name RecentTransactions
extends VBoxContainer

@export
var category: BudgetCategory

@export
var month: BudgetMonth

@export
var visible_count := 5

@onready
var more_label: Label = %MoreLabel

func _ready() -> void:
	reload()

func reload() -> void:
	var transactions := _get_transactions()
	more_label.text = "+%d more" % transactions.size()

func _get_transactions() -> Array[BudgetTransaction]:
	var budget_data := BudgetProvider.get_budget_data()
	if not budget_data:
		return []

	return budget_data.get_transactions_for_category_and_month(category, month)
