class_name SpreadsheetUIStateFactory

var states: Dictionary

func _init() -> void:
	states = {
		SpreadsheetUI.State.IDLE: SpreadsheetUIStateIdle,
		SpreadsheetUI.State.DISABLED: SpreadsheetUIStateDisabled,
	}

func get_fresh_state(state: SpreadsheetUI.State) -> SpreadsheetUIState:
	assert(states.has(state), "State is missing!")
	return states.get(state).new()
