class_name YearGridState
extends Node

signal state_transition_requested(new_state: YearGrid.State, state_data: YearGridStateData)

var _year_grid: YearGrid = null
var _state_data: YearGridStateData = null
var _appearance: YearGridAppearance = null
var _month_grid_manager: MonthGridManager = null
var _index_tracker: IndexTracker = null

func setup(
	year_grid: YearGrid,
	state_data: YearGridStateData,
	appearance: YearGridAppearance,
	month_grid_manager: MonthGridManager,
	index_tracker: IndexTracker,
) -> void:
	_year_grid = year_grid
	_state_data = state_data
	_appearance = appearance
	_month_grid_manager = month_grid_manager
	_index_tracker = index_tracker

func transition_state(
	new_state: YearGrid.State,
	state_data := YearGridStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)

func enable() -> void:
	pass

func disable() -> void:
	pass

func inject_amount(_amount: float) -> void:
	pass

func update_budget(_data: BudgetData) -> void:
	pass
