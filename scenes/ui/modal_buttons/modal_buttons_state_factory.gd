class_name ModalButtonsStateFactory

var states: Dictionary

func _init() -> void:
	states = {
		ModalButtons.State.IDLE: ModalButtonsStateIdle,
		ModalButtons.State.ACTIVE: ModalButtonsStateActive,
	}

func get_fresh_state(state: ModalButtons.State) -> ModalButtonsState:
	assert(states.has(state), "State is missing!")
	return states.get(state).new()
