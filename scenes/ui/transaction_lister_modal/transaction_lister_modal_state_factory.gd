class_name TransactionListerModalStateFactory

var states: Dictionary

func _init() -> void:
	states = {
		TransactionListerModal.State.HIDDEN: TransactionListerModalStateHidden,
		TransactionListerModal.State.SHOWN: TransactionListerModalStateShown,
		TransactionListerModal.State.FINISHING: TransactionListerModalStateFinishing,
	}

func get_fresh_state(state: TransactionListerModal.State) -> TransactionListerModalState:
	assert(states.has(state), "State is missing!")
	return states.get(state).new()
