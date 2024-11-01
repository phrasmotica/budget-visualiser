@tool
extends MarginContainer

@export
var transaction_inputs: Array[TransactionInput] = []

@onready
var transaction_input_container: VBoxContainer = %TransactionInputContainer

@onready
var transaction_input_scene: PackedScene = load("res://scenes/transaction_input.tscn")

var _transactions: Dictionary = {}

signal transactions_changed(transactions: Array[Transaction])

func _ready():
	for ti: TransactionInput in transaction_inputs:
		connect_input(ti)

func handle_adjust_transaction(transaction: Transaction):
	print("Transaction " + str(transaction.id) + " for " + transaction.name + " has amount " + str(transaction.amount))

	_transactions[transaction.id] = transaction

	var transactions := _transactions.values()

	print("Ledger contains " + str(len(transactions)) + " transaction(s)")

	transactions_changed.emit(transactions)

func _on_new_transaction_button_pressed() -> void:
	var ti: TransactionInput = transaction_input_scene.instantiate()
	transaction_input_container.add_child(ti)

	connect_input(ti)

func connect_input(ti: TransactionInput):
	ti.adjust_transaction.connect(handle_adjust_transaction)

	# TODO: collect the initial transactions in a more efficient way
	ti.adjust()
