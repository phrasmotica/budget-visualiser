class_name TransactionListerModalStateHidden
extends TransactionListerModalState

func _enter_tree() -> void:
	Logger.debug("%s is now hidden" % _transaction_lister_modal.name)

	GuideHelper.disable_navigation()

	_transaction_lister_modal.hide()
	_modal_buttons.reset_highlight()

func enable(transactions: Array[BudgetTransaction]) -> void:
	var state_data := TransactionListerModalStateData \
		.build() \
		.with_transactions(transactions)

	transition_state(TransactionListerModal.State.ACTING, state_data)
