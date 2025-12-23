class_name IncomeGrid
extends MarginContainer

enum State { IDLE, DISABLED }

var _state_factory := IncomeGridStateFactory.new()
var _current_state: IncomeGridState = null

func _ready() -> void:
	switch_state(State.IDLE)

func switch_state(state: State, state_data := IncomeGridStateData.new()) -> void:
	if _current_state != null:
		_current_state.queue_free()

	_current_state = _state_factory.get_fresh_state(state)

	_current_state.setup(
		self,
		state_data)

	_current_state.state_transition_requested.connect(switch_state)
	_current_state.name = "IncomeGridStateMachine: %s" % str(state)

	call_deferred("add_child", _current_state)
