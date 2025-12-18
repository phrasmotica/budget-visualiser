class_name TransactionListerModalStateFinishing
extends TransactionListerModalState

func _enter_tree() -> void:
	Logger.debug("%s is now finishing" % _transaction_lister_modal.name)

	_transaction_lister.disable()
	_modal_buttons.activate()

	SignalHelper.persist(
		_modal_buttons.cancelled,
		_cancel
	)

	SignalHelper.persist(
		_modal_buttons.confirmed,
		_finish
	)

func _process(_delta: float) -> void:
	if Input.is_action_just_released("ui_focus_next"):
		var state_data := TransactionListerModalStateData \
			.build() \
			.with_skip_transactions()

		transition_state(TransactionListerModal.State.ACTING, state_data)

	if Input.is_action_just_released("ui_cancel"):
		_cancel()

func disable() -> void:
	_to_hidden()

func _cancel() -> void:
	Logger.info("Cancelled toggling transactions")

	var change_tracker := _transaction_lister.get_change_tracker()
	change_tracker.clear_changes()

	TransactionListerEvents.emit_cancelled()

	_to_hidden()

func _finish() -> void:
	Logger.info("Finished toggling transactions")

	var change_tracker := _transaction_lister.get_change_tracker()
	BudgetProvider.apply_changes(change_tracker)
	change_tracker.clear_changes()

	TransactionListerEvents.emit_cancelled()

	_to_hidden()

func _to_hidden() -> void:
	transition_state(TransactionListerModal.State.HIDDEN)
