class_name EditableLabelStateFactory

var states: Dictionary

func _init() -> void:
	states = {
		EditableLabel.State.IDLE: EditableLabelStateIdle,
		EditableLabel.State.HIGHLIGHTED: EditableLabelStateHighlighted,
		EditableLabel.State.EDITING: EditableLabelStateEditing,
	}

func get_fresh_state(state: EditableLabel.State) -> EditableLabelState:
	assert(states.has(state), "State is missing!")
	return states.get(state).new()
