@tool
class_name AmountMultiLabel
extends MarginContainer

@export
var amounts: Array[float] = []:
	set(value):
		amounts = value

		_refresh()

@onready
var label: Label = %Label

func _ready() -> void:
	_refresh()

func inject_transactions(transactions: Array[BudgetTransaction]) -> void:
	var new_amounts := transactions \
		.filter(func(t: BudgetTransaction): return not t.hidden) \
		.map(func(t: BudgetTransaction): return t.amount)

	# handles conversion of the untyped array...
	amounts.assign(new_amounts)

	# ...but does not got through the setter!
	_refresh()

func _refresh() -> void:
	if label:
		label.text = _compute_text()

func _compute_text() -> String:
	if amounts.size() <= 0:
		return ""

	return Strings.curr_multi(amounts)
