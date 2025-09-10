class_name YearGridState
extends Node

signal state_transition_requested(new_state: YearGrid.State, state_data: YearGridStateData)

var _year_grid: YearGrid = null
var _state_data: YearGridStateData = null
var _month_grid_manager: MonthGridManager = null
var _amount_entry_modal: AmountEntryModal = null
var _index_tracker: IndexTracker = null

func setup(
	year_grid: YearGrid,
	state_data: YearGridStateData,
	month_grid_manager: MonthGridManager,
	amount_entry_modal: AmountEntryModal,
	index_tracker: IndexTracker,
) -> void:
	_year_grid = year_grid
	_state_data = state_data
	_month_grid_manager = month_grid_manager
	_amount_entry_modal = amount_entry_modal
	_index_tracker = index_tracker

func transition_state(
	new_state: YearGrid.State,
	state_data := YearGridStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)
