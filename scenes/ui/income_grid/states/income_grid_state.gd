class_name IncomeGridState
extends Node

signal state_transition_requested(new_state: IncomeGrid.State, state_data: IncomeGridStateData)

var _income_grid: IncomeGrid = null
var _state_data: IncomeGridStateData = null

func setup(
	income_grid: IncomeGrid,
	state_data: IncomeGridStateData,
) -> void:
	_income_grid = income_grid
	_state_data = state_data

func transition_state(
	new_state: IncomeGrid.State,
	state_data := IncomeGridStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)
