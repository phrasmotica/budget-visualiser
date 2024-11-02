@tool
class_name BudgetBar extends VBoxContainer

@onready
var remaining_bar: ColorRect = %RemainingBar

@onready
var spent_bar: ColorRect = %SpentBar

@onready
var remaining_label: Label = %RemainingLabel

@onready
var spent_label: Label = %SpentLabel

func refresh(spent: float, total: float):
	var spent_fraction := spent / total

	if remaining_bar:
		remaining_bar.size_flags_stretch_ratio = 100 * (1 - spent_fraction)

	if spent_bar:
		spent_bar.size_flags_stretch_ratio = 100 * spent_fraction

	# only display whole percentages in labels
	var spent_ratio := roundi(100 * spent / total)

	if remaining_label:
		remaining_label.text = "Remaining: %d%%" % (100 - spent_ratio)

	if spent_label:
		spent_label.text = "Spent: %d%%" % spent_ratio
