@tool
class_name TransactionInput extends HBoxContainer

@export
var transaction: Transaction:
	set(value):
		transaction = value

		handle_transaction_changed()

@onready
var name_edit: LineEdit = %NameEdit

@onready
var amount_edit: MoneyEdit = %AmountEdit

var prevent_callback := false

signal adjust_transaction(transaction: Transaction)

func _ready():
	if not transaction:
		transaction = Transaction.new()
		transaction.id = RandomNumberGenerator.new().randi()

	transaction.changed.connect(handle_transaction_changed)

	update_name()
	update_amount()

func adjust():
	adjust_transaction.emit(transaction)

func update_name():
	if name_edit:
		name_edit.text = transaction.name if transaction else ""

func update_amount():
	if amount_edit:
		amount_edit.amount = transaction.amount if transaction else 0.0

func handle_transaction_changed():
	update_name()
	update_amount()

	adjust()

func _on_name_edit_text_changed(new_text: String) -> void:
	prevent_callback = true
	transaction.name = new_text
	prevent_callback = false

func _on_name_edit_text_submitted(new_text: String) -> void:
	transaction.name = new_text

	adjust()

func _on_name_edit_focus_exited() -> void:
	adjust()

func _on_amount_edit_amount_changed(x: float) -> void:
	prevent_callback = true
	transaction.amount = x
	prevent_callback = false

	adjust()
