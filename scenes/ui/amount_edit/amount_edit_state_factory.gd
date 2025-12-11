class_name AmountEditStateFactory

var states: Dictionary

func _init() -> void:
	states = {
		AmountEdit.State.IDLE: AmountEditStateIdle,
		AmountEdit.State.HIGHLIGHTED: AmountEditStateHighlighted,
	}

func get_fresh_state(state: AmountEdit.State) -> AmountEditState:
	assert(states.has(state), "State is missing!")
	return states.get(state).new()
