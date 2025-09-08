class_name CategoryCell
extends PanelContainer

enum State { IDLE, HIGHLIGHTED, EDITING }

var _state_factory := CategoryCellStateFactory.new()
var _current_state: CategoryCellState = null

func _ready() -> void:
	switch_state(CategoryCell.State.IDLE)

func switch_state(state: State, state_data := CategoryCellStateData.new()) -> void:
	if _current_state != null:
		_current_state.queue_free()

	_current_state = _state_factory.get_fresh_state(state)

	_current_state.setup(
		self,
		state_data)

	_current_state.state_transition_requested.connect(switch_state)
	_current_state.name = "CategoryCellStateMachine: %s" % str(state)

	call_deferred("add_child", _current_state)

func highlight() -> void:
	if _current_state:
		_current_state.highlight()
