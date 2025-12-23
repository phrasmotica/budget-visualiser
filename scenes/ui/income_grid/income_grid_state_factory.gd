class_name IncomeGridStateFactory

var states: Dictionary

func _init() -> void:
	states = {
		IncomeGrid.State.IDLE: IncomeGridStateIdle,
		IncomeGrid.State.DISABLED: IncomeGridStateDisabled,
	}

func get_fresh_state(state: IncomeGrid.State) -> IncomeGridState:
	assert(states.has(state), "State is missing!")
	return states.get(state).new()
