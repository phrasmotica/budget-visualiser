class_name AmountEntryModalStateShown
extends AmountEntryModalState

func _enter_tree() -> void:
	print("%s is now shown" % _amount_entry_modal.name)

	_amount_entry_modal.show()

	_appearance.set_sub_header(_state_data.get_sub_header())
	_appearance.for_shown()

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
	_appearance.set_caption("%.2f -> %.2f" % [starting_amount, preview_amount])

func _process(_delta: float) -> void:
	if Input.is_action_just_released("ui_focus_next"):
		_appearance.switch_amount_edits()

	if Input.is_action_just_released("ui_accept"):
		_finish()

func _set_amount(amount: float) -> void:
	var major_amount := int(amount)
	_totaller.set_major(major_amount)

	var minor_amount := int(100 * (amount - int(amount)))
	_totaller.set_minor(minor_amount)

func _finish() -> void:
	var final_amount := _totaller.compute_total()

	print("Final amount: %.2f" % final_amount)

	AmountEvents.emit_entry_finished(final_amount)

	_to_hidden()

func _to_hidden() -> void:
	transition_state(AmountEntryModal.State.HIDDEN)

func disable() -> void:
	_to_hidden()
