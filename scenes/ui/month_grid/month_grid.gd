class_name MonthGrid
extends Control

enum State { IDLE, HIGHLIGHTED, EDITING }

@onready
var cell_manager: CellManager = %CellManager

var _state_factory := MonthGridStateFactory.new()
var _current_state: MonthGridState = null

var _index_tracker: IndexTracker = null

func _ready() -> void:
	_index_tracker = IndexTracker.new(cell_manager.count() - 1)

	switch_state(MonthGrid.State.IDLE)

func switch_state(state: State, state_data := MonthGridStateData.new()) -> void:
	if _current_state != null:
		_current_state.queue_free()

	_current_state = _state_factory.get_fresh_state(state)

	_current_state.setup(
		self,
		state_data,
		cell_manager,
		_index_tracker)

	_current_state.state_transition_requested.connect(switch_state)
	_current_state.name = "MonthGridStateMachine: %s" % str(state)

	call_deferred("add_child", _current_state)

func highlight() -> void:
	if _current_state:
		_current_state.highlight()

func unhighlight() -> void:
	if _current_state:
		_current_state.unhighlight()
