class_name SectionSummaryGridState
extends Node

signal state_transition_requested(new_state: SectionSummaryGrid.State, state_data: SectionSummaryGridStateData)

var _section_summary_grid: SectionSummaryGrid = null
var _state_data: SectionSummaryGridStateData = null
var _section_cell_manager: SectionCellManager = null

func setup(
	section_summary_grid: SectionSummaryGrid,
	state_data: SectionSummaryGridStateData,
	section_cell_manager: SectionCellManager,
) -> void:
	_section_summary_grid = section_summary_grid
	_state_data = state_data
	_section_cell_manager = section_cell_manager

func transition_state(
	new_state: SectionSummaryGrid.State,
	state_data := SectionSummaryGridStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)

func refresh_appearance() -> void:
	_section_cell_manager.update_amounts(_section_summary_grid.section)
