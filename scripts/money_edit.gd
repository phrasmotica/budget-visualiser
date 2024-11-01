@tool
class_name MoneyEdit extends LineEdit

@export
var amount: float = 0:
	set(value):
		amount = value

		format_text()

signal amount_changed(amount: float)

func _ready():
	format_text()

func format_text():
	if amount >= 0:
		text = "£%.2f" % amount
	else:
		text = "-£%.2f" % -amount

func _on_text_submitted(new_text: String) -> void:
	amount = new_text.to_float()

	amount_changed.emit(amount)

func _on_focus_entered() -> void:
	text = str(amount)

	select_all()

func _on_focus_exited() -> void:
	amount = text.to_float()

	amount_changed.emit(amount)
