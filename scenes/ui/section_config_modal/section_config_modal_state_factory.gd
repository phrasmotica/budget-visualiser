class_name SectionConfigModalStateFactory

var states: Dictionary

func _init() -> void:
	states = {
		SectionConfigModal.State.HIDDEN: SectionConfigModalStateHidden,
		SectionConfigModal.State.SHOWN: SectionConfigModalStateShown,
	}

func get_fresh_state(state: SectionConfigModal.State) -> SectionConfigModalState:
	assert(states.has(state), "State is missing!")
	return states.get(state).new()
