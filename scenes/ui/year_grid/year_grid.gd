class_name YearGrid
extends HBoxContainer

enum State { DISABLED, IDLE }

@onready
var month_grid_manager: MonthGridManager = %MonthGridManager

@onready
var amount_entry_modal: AmountEntryModal = %AmountEntryModal

var _state_factory := YearGridStateFactory.new()
var _current_state: YearGridState = null

var _index_tracker: IndexTracker = null

func _ready() -> void:
	_index_tracker = IndexTracker.new(month_grid_manager.count() - 1)

	switch_state(State.IDLE)

func switch_state(state: State, state_data := YearGridStateData.new()) -> void:
	if _current_state != null:
		_current_state.queue_free()

	_current_state = _state_factory.get_fresh_state(state)

	_current_state.setup(
		self,
		state_data,
		month_grid_manager,
		amount_entry_modal,
		_index_tracker)

	_current_state.state_transition_requested.connect(switch_state)
	_current_state.name = "YearGridStateMachine: %s" % str(state)

	call_deferred("add_child", _current_state)
