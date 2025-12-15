class_name TransactionListerModalStateShown
extends TransactionListerModalState

func _enter_tree() -> void:
	print("%s is now shown" % _transaction_lister_modal.name)

	_transaction_lister_modal.show()

func _process(_delta: float) -> void:
	if Input.is_action_just_released("ui_cancel"):
		TransactionListerEvents.emit_entry_cancelled()

		_to_hidden()

func disable() -> void:
	_to_hidden()

func _to_hidden() -> void:
	transition_state(TransactionListerModal.State.HIDDEN)
