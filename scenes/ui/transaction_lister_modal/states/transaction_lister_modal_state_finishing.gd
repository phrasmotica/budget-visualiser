class_name TransactionListerModalStateFinishing
extends TransactionListerModalState

func _enter_tree() -> void:
	print("%s is now finishing" % _transaction_lister_modal.name)

	_transaction_lister.disable()
	_finished_button.highlight()

	SignalHelper.persist(
		_finished_button.pressed,
		_on_finished
	)

func _on_finished() -> void:
	print("Finished toggling transactions")

	_finish()

func _process(_delta: float) -> void:
	if Input.is_action_just_released("ui_focus_next"):
		_finished_button.unhighlight()

		var state_data := TransactionListerModalStateData \
			.build() \
			.with_skip_transactions()

		transition_state(TransactionListerModal.State.ACTING, state_data)

	if Input.is_action_just_released("ui_cancel"):
		print("Cancelled toggling transactions")

		_finish()

func disable() -> void:
	_to_hidden()

func _finish() -> void:
	_transaction_lister.disable()

	TransactionListerEvents.emit_entry_cancelled()

	_to_hidden()

func _to_hidden() -> void:
	transition_state(TransactionListerModal.State.HIDDEN)
