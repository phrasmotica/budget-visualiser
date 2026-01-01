class_name SectionSummaryGridStateFactory

var states: Dictionary

func _init() -> void:
	states = {
		SectionSummaryGrid.State.IDLE: SectionSummaryGridStateIdle,
		SectionSummaryGrid.State.DISABLED: SectionSummaryGridStateDisabled,
	}

func get_fresh_state(state: SectionSummaryGrid.State) -> SectionSummaryGridState:
	assert(states.has(state), "State is missing!")
	return states.get(state).new()
