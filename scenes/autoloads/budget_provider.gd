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
	preload("res://resources/data/budget_month_may.tres"),
	preload("res://resources/data/budget_month_jun.tres"),
	preload("res://resources/data/budget_month_jul.tres"),
	preload("res://resources/data/budget_month_aug.tres"),
	preload("res://resources/data/budget_month_sep.tres"),
	preload("res://resources/data/budget_month_oct.tres"),
	preload("res://resources/data/budget_month_nov.tres"),
	preload("res://resources/data/budget_month_dec.tres"),
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
	var new_transaction := _data.add_transaction(category, month, amount)
	transaction_added.emit(new_transaction)

	budget_changed.emit(_data)

func get_month_debug() -> BudgetMonth:
	return BUDGET_MONTHS[0]

func get_category_index(category: BudgetCategory) -> int:
	return BUDGET_CATEGORIES.find(category)

func get_category(index: int) -> BudgetCategory:
	return BUDGET_CATEGORIES[index]

func get_amount(category: BudgetCategory, month: BudgetMonth) -> float:
	return _data.compute_category_expenditure_in_month(category, month)
