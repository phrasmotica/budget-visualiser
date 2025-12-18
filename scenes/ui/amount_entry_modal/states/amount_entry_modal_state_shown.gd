class_name AmountEntryModalStateShown
extends AmountEntryModalState

func _enter_tree() -> void:
	Logger.debug("%s is now shown" % _amount_entry_modal.name)

	var category = _state_data.get_category()
	var month = _state_data.get_month()

	_recent_transactions.category = category
	_recent_transactions.month = month
	_recent_transactions.reload()

	_amount_entry_modal.show()

	if category and month:
		_appearance.set_sub_header("%s - %s" % [category.name, month.name])

	_appearance.for_shown()

	SignalHelper.persist(GridInput.move_right, _appearance.switch_amount_edits)
	SignalHelper.persist(GridInput.move_left, _appearance.switch_amount_edits)

	SignalHelper.persist(ConfirmCancelInput.confirm, _finish)
	SignalHelper.persist(ConfirmCancelInput.cancel, _cancel)

	SignalHelper.persist(
		_totaller.total_changed,
		_on_total_changed
	)

	var amount := _state_data.get_amount()
	_set_amount(amount)

	var starting_amount := _state_data.get_starting_amount()
	set_amounts_caption(starting_amount, starting_amount)

func _on_total_changed(total: float) -> void:
	var starting_amount := _state_data.get_starting_amount()
	var preview_amount := starting_amount + total

	set_amounts_caption(starting_amount, preview_amount)

func set_amounts_caption(starting_amount: float, preview_amount: float) -> void:
	var caption := Strings.curr_map(
		"%s -> %s",
		[starting_amount, preview_amount])

	_appearance.set_caption(caption)

func _set_amount(amount: float) -> void:
	var major_amount := int(amount)
	_totaller.set_major(major_amount)

	var minor_amount := int(100 * (amount - int(amount)))
	_totaller.set_minor(minor_amount)

func _cancel() -> void:
	Logger.info("Cancelling amount entry")

	AmountEvents.emit_entry_cancelled()

	_to_hidden()

func _finish() -> void:
	var final_amount := _totaller.compute_total()

	Logger.info("Final amount: %s" % Strings.curr(final_amount))

	AmountEvents.emit_entry_finished(final_amount)

	_to_hidden()

func _to_hidden() -> void:
	transition_state(AmountEntryModal.State.HIDDEN)

func disable() -> void:
	_to_hidden()
