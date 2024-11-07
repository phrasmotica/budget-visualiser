@tool
class_name BudgetBar extends VBoxContainer

@export
var total_budget: float = 3000:
	set(value):
		total_budget = value
		_refresh()

@export
var spent: float = 1000:
	set(value):
		spent = value
		_refresh()

@onready
var remaining_bar: ColorRect = %RemainingBar

@onready
var spent_bar: ColorRect = %SpentBar

@onready
var remaining_label: Label = %RemainingLabel

@onready
var spent_label: Label = %SpentLabel

func _refresh():
	var spent_fraction := spent / total_budget

	if remaining_bar:
		remaining_bar.size_flags_stretch_ratio = 100 * (1 - spent_fraction)

	if spent_bar:
		spent_bar.size_flags_stretch_ratio = 100 * spent_fraction

	# only display whole percentages in labels
	var spent_ratio := roundi(100 * spent / total_budget)

	if remaining_label:
		remaining_label.text = "£%.2f remaining (%d%%)" % [total_budget - spent, (100 - spent_ratio)]

	if spent_label:
		spent_label.text = "£%.2f spent (%d%%)" % [spent, spent_ratio]
