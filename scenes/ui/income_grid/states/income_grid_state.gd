class_name IncomeGridState
extends Node

signal state_transition_requested(new_state: IncomeGrid.State, state_data: IncomeGridStateData)

var _income_grid: IncomeGrid = null
var _state_data: IncomeGridStateData = null
var _section_cell_manager: SectionCellManager = null

func setup(
	income_grid: IncomeGrid,
	state_data: IncomeGridStateData,
	section_cell_manager: SectionCellManager,
) -> void:
	_income_grid = income_grid
	_state_data = state_data
	_section_cell_manager = section_cell_manager

func transition_state(
	new_state: IncomeGrid.State,
	state_data := IncomeGridStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)

func refresh_appearance() -> void:
	_section_cell_manager.update_amounts(_income_grid.section)
