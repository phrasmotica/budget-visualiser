class_name TransactionListerModalStateHidden
extends TransactionListerModalState

func _enter_tree() -> void:
	print("%s is now hidden" % _transaction_lister_modal.name)

	_transaction_lister_modal.hide()

func enable(transactions: Array[BudgetTransaction]) -> void:
	var state_data := TransactionListerModalStateData \
		.build() \
		.with_transactions(transactions)

	transition_state(TransactionListerModal.State.SHOWN, state_data)
