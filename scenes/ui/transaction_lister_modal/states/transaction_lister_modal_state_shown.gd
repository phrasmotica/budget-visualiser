class_name TransactionListerModalStateShown
extends TransactionListerModalState

func _enter_tree() -> void:
	print("%s is now shown" % _transaction_lister_modal.name)

	_transaction_lister_modal.show()

	var transactions := _state_data.get_transactions()

	_transaction_lister.transactions = transactions
	_transaction_lister.enable()

	# TODO: move the "Finished" button outside of the lister, and into the modal
	SignalHelper.persist(
		_transaction_lister.finished,
		_on_finished
	)

func _on_finished() -> void:
	_finish()

func _process(_delta: float) -> void:
	if Input.is_action_just_released("ui_cancel"):
		_finish()

func disable() -> void:
	_to_hidden()

func _finish() -> void:
	_transaction_lister.disable()

	TransactionListerEvents.emit_entry_cancelled()

	_to_hidden()

func _to_hidden() -> void:
	transition_state(TransactionListerModal.State.HIDDEN)
