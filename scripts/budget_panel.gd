@tool
extends MarginContainer

@export
var total_budget: float = 3000:
	set(value):
		total_budget = value

		update_bars()
		update_labels()

		if Engine.is_editor_hint():
			update_budget()

@export
var spent: float = 1000:
	set(value):
		spent = value

		update_bars()
		update_labels()

@onready
var total_budget_edit: MoneyEdit = %TotalBudgetEdit

@onready
var remaining_bar: ColorRect = %RemainingBar

@onready
var spent_bar: ColorRect = %SpentBar

@onready
var remaining_label: Label = %RemainingLabel

@onready
var spent_label: Label = %SpentLabel

func _ready():
	if not Engine.is_editor_hint():
		spent = 0

func update_budget():
	if total_budget_edit:
		total_budget_edit.set_amount(total_budget)

func update_bars():
	var spent_fraction := spent / total_budget

	if remaining_bar:
		remaining_bar.size_flags_stretch_ratio = 100 * (1 - spent_fraction)

	if spent_bar:
		spent_bar.size_flags_stretch_ratio = 100 * spent_fraction

func update_labels():
	var spent_ratio := roundi(100 * spent / total_budget)

	if remaining_label:
		remaining_label.text = "Remaining: %d%%" % (100 - spent_ratio)

	if spent_label:
		spent_label.text = "Spent: %d%%" % spent_ratio

func _on_total_budget_edit_amount_changed(amount: float) -> void:
	total_budget = amount

func _on_ledger_panel_transactions_changed(transactions: Array) -> void:
	spent = transactions.map(func(t): return t.amount).reduce(sumf, 0)

	var remaining := total_budget - spent
	print("There is " + str(remaining) + " left in the budget")

	update_bars()
	update_labels()

func sumf(accum: float, next: float):
	return accum + next
