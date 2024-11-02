@tool
extends MarginContainer

@export
var total_budget: float = 3000:
	set(value):
		total_budget = max(value, spent)

		update_bars()

		if Engine.is_editor_hint():
			update_budget()

@export
var spent: float = 1000:
	set(value):
		spent = value

		update_bars()

@onready
var total_budget_edit: MoneyEdit = %TotalBudgetEdit

@onready
var budget_bar: BudgetBar = %BudgetBar

func _ready():
	if not Engine.is_editor_hint():
		spent = 0

func update_budget():
	if total_budget_edit:
		total_budget_edit.amount = total_budget

func _on_total_budget_edit_amount_changed(amount: float) -> void:
	total_budget = amount

func _on_ledger_panel_transactions_changed(transactions: Array) -> void:
	spent = transactions.map(func(t): return t.amount).reduce(sumf, 0)

	var remaining := total_budget - spent
	print("There is " + str(remaining) + " left in the budget")

func update_bars():
	if budget_bar:
		budget_bar.refresh(spent, total_budget)

func sumf(accum: float, next: float):
	return accum + next
