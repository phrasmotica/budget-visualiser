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

func enable() -> void:
	pass

func disable() -> void:
	pass

func highlight() -> void:
	pass

func unhighlight() -> void:
	pass

func inject_amount(_amount: float) -> void:
	pass

func inject_budget(data: BudgetData) -> void:
	var relevant_transactions := data.get_transactions_for_month(_month_grid.month)
	_cell_manager.inject_transactions(relevant_transactions)

func is_highlighted() -> bool:
	return false
