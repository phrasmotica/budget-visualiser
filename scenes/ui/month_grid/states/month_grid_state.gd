class_name MonthGridState
extends Node

signal state_transition_requested(new_state: MonthGrid.State, state_data: MonthGridStateData)

var _month_grid: MonthGrid = null
var _state_data: MonthGridStateData = null

func setup(
	month_grid: MonthGrid,
	state_data: MonthGridStateData,
) -> void:
	_month_grid = month_grid
	_state_data = state_data

func transition_state(
	new_state: MonthGrid.State,
	state_data := MonthGridStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)
