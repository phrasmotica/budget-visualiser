@tool
class_name TransactionInput extends HBoxContainer

var _transaction_id := -1

@export
var transaction_name: String:
	set(value):
		transaction_name = value

		if not prevent_callback:
			update_name()

@export
var amount: float:
	set(value):
		amount = value

		if not prevent_callback:
			update_amount()

@onready
var name_edit: LineEdit = %NameEdit

@onready
var amount_edit: MoneyEdit = %AmountEdit

var prevent_callback := false

signal adjust_transaction(transaction_id: int, transaction_name: String, amount: float)

func _ready():
	_transaction_id = RandomNumberGenerator.new().randi()

func adjust():
	adjust_transaction.emit(_transaction_id, transaction_name, amount)

func update_name():
	if name_edit:
		name_edit.text = transaction_name

func update_amount():
	if amount_edit:
		amount_edit.amount = amount

func _on_name_edit_text_changed(new_text: String) -> void:
	prevent_callback = true
	transaction_name = new_text
	prevent_callback = false

func _on_name_edit_text_submitted(new_text: String) -> void:
	prevent_callback = true
	transaction_name = new_text
	prevent_callback = false

	adjust()

func _on_name_edit_focus_exited() -> void:
	adjust()

func _on_amount_edit_amount_changed(x: float) -> void:
	prevent_callback = true
	amount = x
	prevent_callback = false

	adjust()
