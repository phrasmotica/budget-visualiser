@tool
class_name BudgetHolder extends Node

@export
var budget_panel: BudgetPanel

@export
var ledger_panel: LedgerPanel

@export
var bills_panel: LedgerPanel

signal budget_changed(budget: Budget)

var _budget_internal: Budget

func inject(budget: Budget):
	_budget_internal = budget

	budget_panel.inject(budget)
	ledger_panel.inject(budget.transactions, budget.transactions_disabled)
	bills_panel.inject(budget.bills, budget.bills_disabled)

func overwrite_transactions(transactions: Array) -> void:
	ensure_budget()

	_budget_internal.transactions.clear()

	for t in transactions:
		print("Overwriting with %s %.2f" % [t.name, t.amount])
		_budget_internal.transactions.append(t as Transaction)

func overwrite_bills(bills: Array) -> void:
	ensure_budget()

	_budget_internal.bills.clear()

	for b in bills:
		print("Overwriting with %s %.2f" % [b.name, b.amount])
		_budget_internal.bills.append(b as Transaction)

func get_budget_id() -> int:
	return _budget_internal.id if _budget_internal else -1

func _on_budget_panel_total_budget_changed(amount: float) -> void:
	ensure_budget()

	_budget_internal.total_budget = amount

	recompute()

	budget_panel.update_bar(_budget_internal)

	broadcast()

func _on_ledger_panel_class_enabled(enabled: bool) -> void:
	ensure_budget()

	_budget_internal.transactions_disabled = not enabled

	recompute()

	budget_panel.update_bar(_budget_internal)

	broadcast()

func _on_ledger_panel_transactions_changed(transactions: Array) -> void:
	overwrite_transactions(transactions)

	recompute()

	budget_panel.update_bar(_budget_internal)

	broadcast()

func _on_bills_panel_class_enabled(enabled: bool) -> void:
	ensure_budget()

	_budget_internal.bills_disabled = not enabled

	recompute()

	budget_panel.update_bar(_budget_internal)

	broadcast()

func _on_bills_panel_transactions_changed(transactions: Array) -> void:
	overwrite_bills(transactions)

	recompute()

	budget_panel.update_bar(_budget_internal)

	broadcast()

func recompute():
	print("There is " + str(_budget_internal.get_remaining()) + " left in the budget")

func ensure_budget():
	if not _budget_internal:
		_budget_internal = Budget.new()
		_budget_internal.id = randi()

func broadcast():
	budget_changed.emit(_budget_internal)

func transaction_is_enabled(t: Transaction):
	return not t.disabled

func sumf(accum: float, next: float):
	return accum + next
