class_name ButtonPanelStateFactory

var states: Dictionary

func _init() -> void:
	states = {
		ButtonPanel.State.IDLE: ButtonPanelStateIdle,
		ButtonPanel.State.HIGHLIGHTED: ButtonPanelStateHighlighted,
	}

func get_fresh_state(state: ButtonPanel.State) -> ButtonPanelState:
	assert(states.has(state), "State is missing!")
	return states.get(state).new()
