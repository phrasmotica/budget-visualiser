extends Node

const BUDGET_MONTHS: Array[BudgetMonth] = [
	preload("res://resources/data/budget_months/budget_month_jan.tres"),
	preload("res://resources/data/budget_months/budget_month_feb.tres"),
	preload("res://resources/data/budget_months/budget_month_mar.tres"),
	preload("res://resources/data/budget_months/budget_month_apr.tres"),
	preload("res://resources/data/budget_months/budget_month_may.tres"),
	preload("res://resources/data/budget_months/budget_month_jun.tres"),
	preload("res://resources/data/budget_months/budget_month_jul.tres"),
	preload("res://resources/data/budget_months/budget_month_aug.tres"),
	preload("res://resources/data/budget_months/budget_month_sep.tres"),
	preload("res://resources/data/budget_months/budget_month_oct.tres"),
	preload("res://resources/data/budget_months/budget_month_nov.tres"),
	preload("res://resources/data/budget_months/budget_month_dec.tres"),
]

var _section: BudgetSection = null
var _data: BudgetData = null

signal budget_changed(data: BudgetData)
signal transaction_added(transaction: BudgetTransaction)

func register_section(section: BudgetSection) -> void:
	_section = section

func set_budget_data(data: BudgetData) -> void:
	_data = data

func get_budget_data() -> BudgetData:
	return _data

func add_transaction(
	category: BudgetCategory,
	month: BudgetMonth,
	amount: float,
) -> void:
	var new_transaction := _data.add_transaction(category, month, amount)
	transaction_added.emit(new_transaction)

	_save_changes()

func apply_changes(change_tracker: TransactionChangeTracker) -> void:
	var transaction_ids := change_tracker.get_transaction_ids()

	if transaction_ids.is_empty():
		print("No changes to apply to the budget!")
		return

	var changed_count := 0

	for id in transaction_ids:
		var transaction: BudgetTransaction = _data.all_transactions.filter(
			func(t: BudgetTransaction):
				return t.id == id
		)[0]

		if not transaction:
			continue

		transaction.hidden = change_tracker.is_hidden(id)

		changed_count += 1

	print("Applied %d change(s) to the budget." % changed_count)

	_save_changes()

func get_month_debug() -> BudgetMonth:
	return BUDGET_MONTHS[0]

func get_category_index(category: BudgetCategory) -> int:
	return _section.get_category_index(category)

func get_category(index: int) -> BudgetCategory:
	return _section.get_category(index)

func get_amount(category: BudgetCategory, month: BudgetMonth) -> float:
	return _data.compute_category_expenditure_in_month(category, month)

func _save_changes() -> void:
	budget_changed.emit(_data)

	SaverLoader.save_budget_data(_data)
