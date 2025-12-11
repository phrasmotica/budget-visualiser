class_name CategoryCellStateFactory

var states: Dictionary

func _init() -> void:
	states = {
		CategoryCell.State.IDLE: CategoryCellStateIdle,
		CategoryCell.State.HIGHLIGHTED: CategoryCellStateHighlighted,
		CategoryCell.State.DIMMED: CategoryCellStateDimmed,
		CategoryCell.State.EDITING: CategoryCellStateEditing,
	}

func get_fresh_state(state: CategoryCell.State) -> CategoryCellState:
	assert(states.has(state), "State is missing!")
	return states.get(state).new()
