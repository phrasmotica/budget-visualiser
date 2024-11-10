@tool
class_name BudgetPanel extends MarginContainer

@export
var total_budget: float = 3000:
	set(value):
		total_budget = max(value, spent)

		if budget_bar:
			budget_bar.total_budget = total_budget

		if Engine.is_editor_hint():
			update_budget()

@export
var spent: float = 1000:
	set(value):
		spent = value

		if budget_bar:
			budget_bar.spent = spent

@onready
var total_budget_edit: MoneyEdit = %TotalBudgetEdit

@onready
var budget_bar: BudgetBar = %BudgetBar

var _budget_internal: Budget
var _transactions_internal: Array[Transaction] = []

signal budget_changed(budget: Budget)

func _ready():
	if not Engine.is_editor_hint():
		spent = 0

func inject(budget: Budget):
	_budget_internal = budget

	total_budget = budget.total_budget
	update_budget()

	overwrite_transactions(budget.transactions)

func update_budget():
	if total_budget_edit:
		total_budget_edit.amount = total_budget

func _on_total_budget_edit_amount_changed(amount: float) -> void:
	total_budget = amount

	broadcast()

func overwrite_transactions(transactions: Array) -> void:
	_transactions_internal.clear()

	for t in transactions:
		print("Overwriting with %s %.2f" % [t.name, t.amount])
		_transactions_internal.append(t as Transaction)

	spent = _transactions_internal.map(func(t): return t.amount).reduce(sumf, 0)

	var remaining := total_budget - spent
	print("There is " + str(remaining) + " left in the budget")

func _on_ledger_panel_transactions_changed(transactions: Array) -> void:
	overwrite_transactions(transactions)

	broadcast()

func sumf(accum: float, next: float):
	return accum + next

func broadcast():
	if not _budget_internal:
		_budget_internal = Budget.new()
		_budget_internal.id = randi()

	_budget_internal.total_budget = total_budget
	_budget_internal.transactions = _transactions_internal

	# budget name is set elsewhere

	budget_changed.emit(_budget_internal)
