class_name DigitSpinnerStateIdle
extends DigitSpinnerState

func _enter_tree() -> void:
	CustomLogger.debug("%s is now idle" % _digit_spinner.name)

	_appearance.for_idle()

	SignalHelper.persist(
		ConfirmCancelInput.confirm,
		_to_active
	)

func _to_active() -> void:
	transition_state(DigitSpinner.State.ACTIVE)

func highlight() -> void:
	_to_active()
