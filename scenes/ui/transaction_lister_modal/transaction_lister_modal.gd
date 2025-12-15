@tool
class_name TransactionListerModal
extends Control

enum State { HIDDEN, SHOWN }

var _state_factory := TransactionListerModalStateFactory.new()
var _current_state: TransactionListerModalState = null

func _ready() -> void:
	_refresh()

	if Engine.is_editor_hint():
		return

	switch_state(State.HIDDEN)

func switch_state(state: State, state_data := TransactionListerModalStateData.new()) -> void:
	if _current_state != null:
		_current_state.queue_free()

	_current_state = _state_factory.get_fresh_state(state)

	_current_state.setup(
		self,
		state_data)

	_current_state.state_transition_requested.connect(switch_state)
	_current_state.name = "TransactionListerModalStateMachine: %s" % str(state)

	call_deferred("add_child", _current_state)

func _refresh() -> void:
	pass
