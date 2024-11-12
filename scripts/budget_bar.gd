@tool
class_name BudgetBar extends VBoxContainer

@export
var total_budget: float = 3000:
	set(value):
		total_budget = value
		_refresh()

@export
var spent: float = 0:
	set(value):
		spent = value
		_refresh()

@export
var bills_spent: float = 1000:
	set(value):
		bills_spent = value
		_refresh()

@export
var underspent_colour: Color:
	set(value):
		underspent_colour = value
		_refresh()

@export
var overspent_colour: Color:
	set(value):
		overspent_colour = value
		_refresh()

@onready
var remaining_bar: ColorRect = %RemainingBar

@onready
var spent_bar: ColorRect = %SpentBar

@onready
var bills_bar: ColorRect = %BillsBar

@onready
var remaining_label: Label = %RemainingLabel

@onready
var spent_label: Label = %SpentLabel

func _refresh():
	var bills_spent_fraction := clampf(bills_spent / total_budget, 0, 1)
	var spent_fraction := clampf(spent / total_budget, 0, 1)

	var total_spent_fraction := bills_spent_fraction + spent_fraction
	if total_spent_fraction > 1:
		# assume the bills did not cost more than the total budget
		spent_fraction = 1 - bills_spent_fraction

	if remaining_bar:
		remaining_bar.size_flags_stretch_ratio = 100 * (1 - spent_fraction - bills_spent_fraction)

	if spent_bar:
		spent_bar.size_flags_stretch_ratio = 100 * spent_fraction

	if bills_bar:
		bills_bar.size_flags_stretch_ratio = 100 * bills_spent_fraction

	# only display whole percentages in labels
	var total_spent := spent + bills_spent
	var remaining_amount := total_budget - total_spent
	var spent_ratio := clampi(roundi(100 * total_spent / total_budget), 0, 100)

	if remaining_label:
		if remaining_amount >= 0:
			spent_bar.color = underspent_colour
			remaining_label.text = "£%.2f remaining (%d%%)" % [remaining_amount, (100 - spent_ratio)]
		else:
			spent_bar.color = overspent_colour
			remaining_label.text = "£%.2f deficit!" % [-remaining_amount]

	if spent_label:
		spent_label.text = "£%.2f spent (%d%%)" % [total_spent, spent_ratio]
