class_name TransactionLister
extends VBoxContainer

enum State { DISABLED, ENABLED }

var _state_factory := TransactionListerStateFactory.new()
var _current_state: TransactionListerState = null

func _ready() -> void:
	switch_state(TransactionLister.State.DISABLED)

func switch_state(state: State, state_data := TransactionListerStateData.new()) -> void:
	if _current_state != null:
		_current_state.queue_free()

	_current_state = _state_factory.get_fresh_state(state)

	_current_state.setup(
		self,
		state_data)

	_current_state.state_transition_requested.connect(switch_state)
	_current_state.name = "TransactionListerStateMachine: %s" % str(state)

	call_deferred("add_child", _current_state)
