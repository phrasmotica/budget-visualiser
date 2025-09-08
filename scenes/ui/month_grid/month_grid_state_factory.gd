class_name MonthGridStateFactory

var states: Dictionary

func _init() -> void:
	states = {
		MonthGrid.State.IDLE: MonthGridStateIdle,
		MonthGrid.State.HIGHLIGHTED: MonthGridStateHighlighted,
		MonthGrid.State.EDITING: MonthGridStateEditing,
	}

func get_fresh_state(state: MonthGrid.State) -> MonthGridState:
	assert(states.has(state), "State is missing!")
	return states.get(state).new()
