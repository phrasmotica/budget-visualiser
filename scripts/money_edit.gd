@tool
class_name MoneyEdit extends LineEdit

@export
var amount: float = 0:
	set(value):
		amount = value

		format_text()

		if not prevent_callback:
			amount_changed.emit(amount)

var prevent_callback := false

signal amount_changed(amount: float)

func _ready():
	format_text()

func set_amount(x: float):
	prevent_callback = true

	amount = x

	prevent_callback = false

func format_text():
	if amount >= 0:
		text = "£%.2f" % amount
	else:
		text = "-£%.2f" % -amount
