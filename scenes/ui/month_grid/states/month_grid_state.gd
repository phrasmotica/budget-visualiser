class_name MonthGridState
extends Node

signal state_transition_requested(new_state: MonthGrid.State, state_data: MonthGridStateData)

var _month_grid: MonthGrid = null
var _state_data: MonthGridStateData = null
var _cell_manager: CellManager = null
var _index_tracker: IndexTracker = null

func setup(
	month_grid: MonthGrid,
	state_data: MonthGridStateData,
	cell_manager: CellManager,
	index_tracker: IndexTracker,
) -> void:
	_month_grid = month_grid
	_state_data = state_data
	_cell_manager = cell_manager
	_index_tracker = index_tracker

func transition_state(
	new_state: MonthGrid.State,
	state_data := MonthGridStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)

func highlight() -> void:
	pass

func unhighlight() -> void:
	pass
