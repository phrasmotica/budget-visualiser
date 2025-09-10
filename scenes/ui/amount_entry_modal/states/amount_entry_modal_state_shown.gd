class_name AmountEntryModalStateShown
extends AmountEntryModalState

func _enter_tree() -> void:
	print("%s is now shown" % _amount_entry_modal.name)

	_amount_entry_modal.show()

	_appearance.for_shown()

	var amount := _state_data.get_amount()
	_set_amount(amount)

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
