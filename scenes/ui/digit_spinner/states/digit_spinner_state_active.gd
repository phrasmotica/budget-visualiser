class_name DigitSpinnerStateActive
extends DigitSpinnerState

func _enter_tree() -> void:
	CustomLogger.debug("%s is now active" % _digit_spinner.name)

	_appearance.for_active()

	SignalHelper.persist(
		ConfirmCancelInput.confirm,
		_to_idle
	)

	SignalHelper.persist(
		GridInput.move_up,
		_increment
	)

	SignalHelper.persist(
		GridInput.move_down,
		_decrement
	)

func _to_idle() -> void:
	transition_state(DigitSpinner.State.IDLE)

func _increment() -> void:
	_digit_spinner.amount += 1
	_digit_spinner.emit_amount_changed()

func _decrement() -> void:
	_digit_spinner.amount -= 1
	_digit_spinner.emit_amount_changed()

func unhighlight() -> void:
	_to_idle()
