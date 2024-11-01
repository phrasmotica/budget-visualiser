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

func handle_adjust_transaction(transaction_id: int, transaction_name: String, amount: float):
	print("Transaction " + str(transaction_id) + " for " + transaction_name + " has amount " + str(amount))

	if _transactions.has(transaction_id):
		_transactions[transaction_id].name = transaction_name
		_transactions[transaction_id].amount = amount
	else:
		var new_transaction := Transaction.new()
		new_transaction.id = transaction_id
		new_transaction.name = transaction_name
		new_transaction.amount = amount

		_transactions[transaction_id] = new_transaction

	var transactions := _transactions.values()

	print("Ledger contains " + str(len(transactions)) + " transaction(s)")

	transactions_changed.emit(transactions)
