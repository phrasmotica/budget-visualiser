class_name AmountEntryModalStateShown
extends AmountEntryModalState

const MAPPING_CONTEXT: GUIDEMappingContext = preload(
	"res://resources/input/ctx_new_transaction_modal_acting.tres")

func _enter_tree() -> void:
	Logger.debug("%s is now shown" % _amount_entry_modal.name)

	GUIDE.enable_mapping_context(MAPPING_CONTEXT)

	var category = _state_data.get_category()
	var month = _state_data.get_month()

	_recent_transactions.category = category
	_recent_transactions.month = month
	_recent_transactions.reload()

	_amount_entry_modal.show()

	if category and month:
		_appearance.set_sub_header("%s - %s" % [category.name, month.name])

	_appearance.for_shown()

	SignalHelper.persist(GridInput.move_right, _appearance.next_column)
	SignalHelper.persist(GridInput.move_left, _appearance.previous_column)

	SignalHelper.persist(ConfirmCancelInput.confirm, _finish)
	SignalHelper.persist(ConfirmCancelInput.cancel, _cancel)

	SignalHelper.persist(
		_spinner.amount_changed,
		_on_amount_changed
	)

	var amount := _state_data.get_amount()
	_spinner.amount = amount

	var starting_amount := _state_data.get_starting_amount()
	set_amounts_caption(starting_amount, starting_amount)

func _exit_tree() -> void:
	GUIDE.disable_mapping_context(MAPPING_CONTEXT)

func _on_amount_changed(total: float) -> void:
	var starting_amount := _state_data.get_starting_amount()
	var preview_amount := starting_amount + total

	set_amounts_caption(starting_amount, preview_amount)

func set_amounts_caption(starting_amount: float, preview_amount: float) -> void:
	var caption := Strings.curr_map(
		"%s -> %s",
		[starting_amount, preview_amount])

	_appearance.set_caption(caption)

func _cancel() -> void:
	Logger.info("Cancelling amount entry")

	AmountEvents.emit_entry_cancelled()

	_to_hidden()

func _finish() -> void:
	var final_amount := _spinner.compute_amount()

	Logger.info("Final amount: %s" % Strings.curr(final_amount))

	AmountEvents.emit_entry_finished(final_amount)

	_to_hidden()

func _to_hidden() -> void:
	transition_state(AmountEntryModal.State.HIDDEN)

func disable() -> void:
	_to_hidden()
