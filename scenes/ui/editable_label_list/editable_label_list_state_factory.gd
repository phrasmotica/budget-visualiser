class_name EditableLabelListStateFactory

var states: Dictionary

func _init() -> void:
	states = {
		EditableLabelList.State.IDLE: EditableLabelListStateIdle,
		EditableLabelList.State.ACTIVE: EditableLabelListStateActive,
	}

func get_fresh_state(state: EditableLabelList.State) -> EditableLabelListState:
	assert(states.has(state), "State is missing!")
	return states.get(state).new()
