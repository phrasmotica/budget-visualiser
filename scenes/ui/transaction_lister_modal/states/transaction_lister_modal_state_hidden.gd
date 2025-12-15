class_name TransactionListerModalStateHidden
extends TransactionListerModalState

func _enter_tree() -> void:
	print("%s is now hidden" % _transaction_lister_modal.name)

	_transaction_lister_modal.hide()

func enable() -> void:
	transition_state(TransactionListerModal.State.SHOWN)
