@tool
class_name TransactionInput extends HBoxContainer

@export
var transaction: Transaction:
	set(value):
		transaction = value

		update_name()
		update_amount()

@export
var delete_mode: bool:
	set(value):
		delete_mode = value

		update_delete_mode()

@onready
var name_edit: LineEdit = %NameEdit

@onready
var amount_edit: MoneyEdit = %AmountEdit

@onready
var delete_button: Button = %DeleteButton

@onready
var check_box: Button = %CheckBox

signal adjust_transaction(transaction: Transaction)
signal delete_transaction(input: TransactionInput, transaction: Transaction)

func _ready():
	update_name()
	update_amount()
	update_delete_mode()
	update_checkbox()

func adjust():
	if transaction:
		adjust_transaction.emit(transaction)

func update_name():
	if name_edit:
		name_edit.text = transaction.name if transaction else ""
		name_edit.caret_column = len(name_edit.text)

func update_amount():
	if amount_edit:
		amount_edit.amount = transaction.amount if transaction else 0.0

func update_delete_mode():
	if amount_edit:
		amount_edit.visible = not delete_mode

	if delete_button:
		delete_button.visible = delete_mode

func update_checkbox():
	check_box.button_pressed = not transaction.disabled if transaction else true

func handle_transaction_changed():
	update_name()
	update_amount()
	update_checkbox()

	adjust()

func ensure_transaction(new_name := ""):
	if not transaction:
		print("Creating transaction with name " + new_name)

		transaction = Transaction.new()
		transaction.id = randi()
		transaction.name = new_name

		transaction.changed.connect(handle_transaction_changed)

		update_name()

		adjust()

func highlight():
	if name_edit:
		name_edit.grab_focus()

func _on_name_edit_text_changed(new_text: String) -> void:
	ensure_transaction(new_text)

	transaction.set_transaction_name(new_text, false)

func _on_name_edit_text_submitted(new_text: String) -> void:
	ensure_transaction(new_text)

	transaction.set_transaction_name(new_text, true)

func _on_name_edit_focus_exited() -> void:
	# TODO: only adjust if the current text is different to before
	adjust()

func _on_amount_edit_amount_changed(x: float) -> void:
	ensure_transaction()

	transaction.amount = x

	adjust()

func _on_delete_button_pressed() -> void:
	delete_transaction.emit(self, transaction)

func _on_check_box_pressed() -> void:
	ensure_transaction()

	transaction.disabled = not check_box.button_pressed

	adjust()
