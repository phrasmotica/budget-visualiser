class_name DigitSpinnerStateFactory

var states: Dictionary

func _init() -> void:
	states = {
		DigitSpinner.State.IDLE: DigitSpinnerStateIdle,
		DigitSpinner.State.ACTIVE: DigitSpinnerStateActive,
	}

func get_fresh_state(state: DigitSpinner.State) -> DigitSpinnerState:
	assert(states.has(state), "State is missing!")
	return states.get(state).new()
