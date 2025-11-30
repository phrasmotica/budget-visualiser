extends Node

const BUDGET_CATEGORIES: Array[BudgetCategory] = [
	preload("res://resources/data/budget_category_groceries.tres"),
	preload("res://resources/data/budget_category_transport.tres"),
	preload("res://resources/data/budget_category_drinksout.tres"),
	preload("res://resources/data/budget_category_mealsout.tres"),
	preload("res://resources/data/budget_category_pool.tres"),
]

const BUDGET_MONTHS: Array[BudgetMonth] = [
	preload("res://resources/data/budget_month_jan.tres"),
	preload("res://resources/data/budget_month_feb.tres"),
	preload("res://resources/data/budget_month_mar.tres"),
	preload("res://resources/data/budget_month_apr.tres"),
]

var _data: BudgetData = null

signal budget_changed(data: BudgetData)
signal transaction_added(transaction: BudgetTransaction)

func set_budget_data(data: BudgetData) -> void:
	_data = data

func get_budget_data() -> BudgetData:
	return _data

func add_transaction(
	category: BudgetCategory,
	month: BudgetMonth,
	amount: float,
) -> void:
	var new_transaction = _data.add_transaction(category, month, amount)
	transaction_added.emit(new_transaction)

	budget_changed.emit(_data)

func add_transaction_debug(
	amount: float,
) -> void:
	add_transaction(
		BUDGET_CATEGORIES.pick_random(),
		BUDGET_MONTHS.pick_random(),
		amount)

func get_month_debug() -> BudgetMonth:
	return BUDGET_MONTHS[0]
