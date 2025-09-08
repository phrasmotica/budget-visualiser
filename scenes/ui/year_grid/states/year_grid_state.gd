class_name YearGridState
extends Node

signal state_transition_requested(new_state: YearGrid.State, state_data: YearGridStateData)

var _year_grid: YearGrid = null
var _state_data: YearGridStateData = null
var _month_grid_manager: MonthGridManager = null

func setup(
	year_grid: YearGrid,
	state_data: YearGridStateData,
	month_grid_manager: MonthGridManager,
) -> void:
	_year_grid = year_grid
	_state_data = state_data
	_month_grid_manager = month_grid_manager

func transition_state(
	new_state: YearGrid.State,
	state_data := YearGridStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)
