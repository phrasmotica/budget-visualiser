class_name TransactionSelectPanelStateFactory

var states: Dictionary

func _init() -> void:
	states = {
		TransactionSelectPanel.State.IDLE: TransactionSelectPanelStateIdle,
		TransactionSelectPanel.State.HIGHLIGHTED: TransactionSelectPanelStateHighlighted,
	}

func get_fresh_state(state: TransactionSelectPanel.State) -> TransactionSelectPanelState:
	assert(states.has(state), "State is missing!")
	return states.get(state).new()
