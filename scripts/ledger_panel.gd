@tool
class_name LedgerPanel extends MarginContainer

@export
var title := "Ledger":
	set(value):
		title = value

		update_title()

@export
var colour_hint: Color:
	set(value):
		colour_hint = value

		update_colour_hint()

@export
var transactions_disabled := false:
	set(value):
		transactions_disabled = value

		update_checkbox()

@export
var transaction_inputs: Array[TransactionInput] = []

@onready
var title_label: Label = %TitleLabel

@onready
var colour_hint_rect: ColorRect = %ColourHintRect

@onready
var check_box: Button = %CheckBox

@onready
var transaction_input_container: VBoxContainer = %TransactionInputContainer

@onready
var transaction_input_scene: PackedScene = load("res://scenes/transaction_input.tscn")

var _transactions: Dictionary = {}
var _prevent_input := false

signal class_enabled(enabled: bool)
signal transactions_changed(transactions: Array[Transaction])

func _ready():
	update_title()
	update_colour_hint()
	update_checkbox()

	for ti: TransactionInput in transaction_inputs:
		connect_input(ti)

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		return

	if not _prevent_input:
		handle_input()

func handle_input():
	if Input.is_action_just_pressed("modify_mode"):
		set_delete_mode(true)
	elif Input.is_action_just_released("modify_mode"):
		set_delete_mode(false)

func set_delete_mode(is_delete_mode: bool):
	for ti: TransactionInput in transaction_inputs:
		ti.delete_mode = is_delete_mode

func inject(transactions: Array[Transaction], disabled: bool):
	transactions_disabled = disabled

	for ti in transaction_input_container.get_children():
		transaction_input_container.remove_child(ti)

	_transactions.clear()
	transaction_inputs.clear()

	for i in len(transactions):
		var t := transactions[i]

		var ti: TransactionInput = transaction_input_scene.instantiate()
		ti.transaction = t

		_transactions[t.id] = t

		transaction_input_container.add_child(ti)
		transaction_inputs.append(ti)
		connect_input(ti)

func update_title():
	if title_label:
		title_label.text = title

func update_colour_hint():
	if colour_hint_rect:
		colour_hint_rect.color = colour_hint

func update_checkbox():
	if check_box:
		check_box.button_pressed = not transactions_disabled

func handle_adjust_transaction(transaction: Transaction) -> void:
	print("Transaction " + str(transaction.id) + " for " + transaction.name + " has amount " + str(transaction.amount))

	_transactions[transaction.id] = transaction

	refresh()

func handle_delete_transaction(input: TransactionInput, transaction: Transaction) -> void:
	if input:
		transaction_inputs.erase(input)
		transaction_input_container.remove_child(input)
		input.queue_free()

	if transaction:
		print("Transaction " + str(transaction.id) + " for " + transaction.name + " deleted")
		_transactions.erase(transaction.id)

	refresh()

func _on_new_transaction_button_pressed() -> void:
	var ti: TransactionInput = transaction_input_scene.instantiate()

	transaction_input_container.add_child(ti)
	transaction_inputs.append(ti)
	connect_input(ti)

	ti.adjust()
	ti.highlight()

func connect_input(ti: TransactionInput):
	ti.adjust_transaction.connect(handle_adjust_transaction)
	ti.delete_transaction.connect(handle_delete_transaction)

func refresh() -> void:
	var transactions := _transactions.values()

	print("Ledger contains " + str(len(transactions)) + " transaction(s)")

	transactions_changed.emit(transactions)

func prevent_input() -> void:
	set_delete_mode(false)
	_prevent_input = true

func allow_input() -> void:
	_prevent_input = false

func _on_check_box_pressed() -> void:
	class_enabled.emit(check_box.button_pressed)
