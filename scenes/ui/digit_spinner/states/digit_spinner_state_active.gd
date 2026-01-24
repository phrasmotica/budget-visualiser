class_name DigitSpinnerStateActive
extends DigitSpinnerState

func _enter_tree() -> void:
	Logger.debug("%s is now active" % _digit_spinner.name)

	_appearance.for_active()

	SignalHelper.persist(
		ConfirmCancelInput.confirm,
		transition_state.bind(DigitSpinner.State.IDLE)
	)

	SignalHelper.persist(
		GridInput.move_up,
		_increment
	)

	SignalHelper.persist(
		GridInput.move_down,
		_decrement
	)

func _increment() -> void:
	var new_amount := _amount_tracker.add(1)
	_appearance.set_amount(new_amount)

	_digit_spinner.emit_amount_changed(new_amount)

func _decrement() -> void:
	var new_amount := _amount_tracker.subtract(1)
	_appearance.set_amount(new_amount)

	_digit_spinner.emit_amount_changed(new_amount)
