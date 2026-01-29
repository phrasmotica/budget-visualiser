@tool
class_name EditableLabelList
extends VBoxContainer

enum State { IDLE, ACTIVE, DISABLED }

@onready
var label_manager: EditableLabelManager = %LabelManager

var _state_factory := EditableLabelListStateFactory.new()
var _current_state: EditableLabelListState = null

func _ready() -> void:
	_refresh()

	if Engine.is_editor_hint():
		return

	switch_state(State.IDLE)

func switch_state(state: State, state_data := EditableLabelListStateData.new()) -> void:
	if _current_state != null:
		_current_state.queue_free()

	_current_state = _state_factory.get_fresh_state(state)

	_current_state.setup(
		self,
		state_data,
		label_manager)

	_current_state.state_transition_requested.connect(switch_state)
	_current_state.name = "EditableLabelListStateMachine: %s" % str(state)

	call_deferred("add_child", _current_state)

func _refresh() -> void:
	pass

func activate() -> void:
	if _current_state:
		_current_state.activate()

func deactivate() -> void:
	if _current_state:
		_current_state.deactivate()
