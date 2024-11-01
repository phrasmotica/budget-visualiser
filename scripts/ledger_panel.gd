@tool
extends MarginContainer

@export
var transaction_inputs: Array[TransactionInput] = []

var _transactions: Dictionary = {}

signal transactions_changed(transactions: Array[Transaction])

func _ready():
	for ti: TransactionInput in transaction_inputs:
		ti.adjust_transaction.connect(handle_adjust_transaction)

		# TODO: collect the initial transactions in a more efficient way
		ti.adjust()

func handle_adjust_transaction(transaction: Transaction):
	print("Transaction " + str(transaction.id) + " for " + transaction.name + " has amount " + str(transaction.amount))

	_transactions[transaction.id] = transaction

	var transactions := _transactions.values()

	print("Ledger contains " + str(len(transactions)) + " transaction(s)")

	transactions_changed.emit(transactions)
