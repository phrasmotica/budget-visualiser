class_name TransactionListerStateFactory

var states: Dictionary

func _init() -> void:
	states = {
		TransactionLister.State.DISABLED: TransactionListerStateDisabled,
		TransactionLister.State.ENABLED: TransactionListerStateEnabled,
		TransactionLister.State.FINISHING: TransactionListerStateFinishing,
	}

func get_fresh_state(state: TransactionLister.State) -> TransactionListerState:
	assert(states.has(state), "State is missing!")
	return states.get(state).new()
