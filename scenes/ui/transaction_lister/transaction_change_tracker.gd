class_name TransactionChangeTracker

var _changes_hidden: Dictionary[int, bool] = {}

func toggle_hidden(transaction: BudgetTransaction) -> bool:
	var new_hidden := not transaction.hidden

	if _changes_hidden.has(transaction.id):
		new_hidden = not _changes_hidden[transaction.id]

	print("Transaction %d hidden: %s->%s" % [transaction.id, transaction.hidden, new_hidden])

	_changes_hidden[transaction.id] = new_hidden

	return new_hidden

func get_transaction_ids() -> Array[int]:
	return _changes_hidden.keys()

func is_hidden(transaction_id: int) -> bool:
	return _changes_hidden.get(transaction_id, false)

func clear_changes() -> void:
	_changes_hidden.clear()
