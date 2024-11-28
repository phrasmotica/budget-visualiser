@tool
class_name BudgetPanel extends MarginContainer

@onready
var total_budget_edit: MoneyEdit = %TotalBudgetEdit

@onready
var budget_bar: BudgetBar = %BudgetBar

signal total_budget_changed(amount: float)

# TODO: allow copying bills from another budget

# TODO: allow inserting another budget as a "ghost" transaction. Click through
# to view it, its amount should auto-update when that budget changes, etc.

func inject(budget: Budget):
	update_budget(budget)
	update_bar(budget)

func update_budget(budget: Budget):
	if total_budget_edit:
		total_budget_edit.amount = budget.total_budget

func update_bar(budget: Budget):
	if budget_bar:
		budget_bar.total_budget = budget.total_budget
		budget_bar.spent = budget.get_spent()
		budget_bar.bills_spent = budget.get_bills_spent()

func _on_total_budget_edit_amount_changed(amount: float) -> void:
	total_budget_changed.emit(amount)
