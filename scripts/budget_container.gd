@tool
class_name BudgetContainer extends MarginContainer

@onready
var budget_panel: BudgetPanel = %BudgetPanel

@onready
var ledger_panel: LedgerPanel = %LedgerPanel

@onready
var bills_panel: LedgerPanel = %BillsPanel

signal budget_changed(budget: Budget)

func inject(budget: Budget):
	budget_panel.inject(budget)
	ledger_panel.inject(budget.transactions)
	bills_panel.inject(budget.bills)

func prevent_input():
	ledger_panel.prevent_input()
	bills_panel.prevent_input()

func allow_input():
	ledger_panel.allow_input()
	bills_panel.allow_input()

func _on_budget_panel_budget_changed(budget: Budget) -> void:
	budget_changed.emit(budget)
