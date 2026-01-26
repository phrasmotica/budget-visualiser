class_name AmountCellStateFactory

var states: Dictionary

func _init() -> void:
	states = {
		AmountCell.State.IDLE: AmountCellStateIdle,
		AmountCell.State.HIGHLIGHTED: AmountCellStateHighlighted,
		AmountCell.State.DIMMED: AmountCellStateDimmed,
		AmountCell.State.EDITING: AmountCellStateEditing,
	}

func get_fresh_state(state: AmountCell.State) -> AmountCellState:
	assert(states.has(state), "State is missing!")
	return states.get(state).new()
