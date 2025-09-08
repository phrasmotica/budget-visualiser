class_name YearGridStateFactory

var states: Dictionary

func _init() -> void:
	states = {
		YearGrid.State.DISABLED: YearGridStateDisabled,
		YearGrid.State.IDLE: YearGridStateIdle,
	}

func get_fresh_state(state: YearGrid.State) -> YearGridState:
	assert(states.has(state), "State is missing!")
	return states.get(state).new()
