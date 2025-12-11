class_name AmountEntryModalStateFactory

var states: Dictionary

func _init() -> void:
	states = {
		AmountEntryModal.State.HIDDEN: AmountEntryModalStateHidden,
		AmountEntryModal.State.SHOWN: AmountEntryModalStateShown,
	}

func get_fresh_state(state: AmountEntryModal.State) -> AmountEntryModalState:
	assert(states.has(state), "State is missing!")
	return states.get(state).new()
