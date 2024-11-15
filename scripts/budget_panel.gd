@tool
class_name BudgetPanel extends MarginContainer

@export
var total_budget: float = 3000:
	set(value):
		total_budget = max(value, spent)

		update_bar()

		if Engine.is_editor_hint():
			update_budget()

@export
var spent: float = 0:
	set(value):
		spent = value

		update_bar()

@export
var bills_spent: float = 1000:
	set(value):
		bills_spent = value

		update_bar()

@onready
var total_budget_edit: MoneyEdit = %TotalBudgetEdit

@onready
var budget_bar: BudgetBar = %BudgetBar

var _budget_internal: Budget
var _transactions_internal: Array[Transaction] = []
var _bills_internal: Array[Transaction] = []

signal budget_changed(budget: Budget)

func _ready():
	if not Engine.is_editor_hint():
		spent = 0

func inject(budget: Budget):
	_budget_internal = budget

	total_budget = budget.total_budget
	update_budget()

	overwrite_transactions(budget.transactions)
	overwrite_bills(budget.bills)

func update_budget():
	if total_budget_edit:
		total_budget_edit.amount = total_budget

func update_bar():
	if not _budget_internal:
		return

	if budget_bar:
		budget_bar.total_budget = total_budget
		budget_bar.spent = 0.0 if _budget_internal.transactions_disabled else spent
		budget_bar.bills_spent = 0.0 if _budget_internal.bills_disabled else bills_spent

func _on_total_budget_edit_amount_changed(amount: float) -> void:
	total_budget = amount

	broadcast()

func overwrite_transactions(transactions: Array) -> void:
	_transactions_internal.clear()

	for t in transactions:
		print("Overwriting with %s %.2f" % [t.name, t.amount])
		_transactions_internal.append(t as Transaction)

	var enabled_transactions := _transactions_internal.filter(transaction_is_enabled)
	spent = enabled_transactions.map(func(t): return t.amount).reduce(sumf, 0)

	recompute()

func overwrite_bills(bills: Array) -> void:
	_bills_internal.clear()

	for b in bills:
		print("Overwriting with %s %.2f" % [b.name, b.amount])
		_bills_internal.append(b as Transaction)

	var enabled_bills := _bills_internal.filter(transaction_is_enabled)
	bills_spent = enabled_bills.map(func(t): return t.amount).reduce(sumf, 0)

	recompute()

func _on_ledger_panel_class_enabled(enabled: bool) -> void:
	_budget_internal.transactions_disabled = not enabled

	recompute()
	update_bar()
	broadcast()

func _on_ledger_panel_transactions_changed(transactions: Array) -> void:
	overwrite_transactions(transactions)

	broadcast()

func _on_bills_panel_class_enabled(enabled: bool) -> void:
	_budget_internal.bills_disabled = not enabled

	recompute()
	update_bar()
	broadcast()

func _on_bills_panel_transactions_changed(transactions: Array) -> void:
	overwrite_bills(transactions)

	broadcast()

func transaction_is_enabled(t: Transaction):
	return not t.disabled

func sumf(accum: float, next: float):
	return accum + next

func recompute():
	var remaining := total_budget

	if not _budget_internal.transactions_disabled:
		remaining -= spent

	if not _budget_internal.bills_disabled:
		remaining -= bills_spent

	print("There is " + str(remaining) + " left in the budget")

func broadcast():
	if not _budget_internal:
		_budget_internal = Budget.new()
		_budget_internal.id = randi()

	_budget_internal.total_budget = total_budget
	_budget_internal.transactions = _transactions_internal
	_budget_internal.bills = _bills_internal

	# budget name is set elsewhere

	budget_changed.emit(_budget_internal)
