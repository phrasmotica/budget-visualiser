class_name SpreadsheetUIState
extends Node

signal state_transition_requested(new_state: SpreadsheetUI.State, state_data: SpreadsheetUIStateData)

var _spreadsheet_ui: SpreadsheetUI = null
var _state_data: SpreadsheetUIStateData = null
var _year_grid: YearGrid = null
var _amount_entry_modal: AmountEntryModal = null

func setup(
	spreadsheet_ui: SpreadsheetUI,
	state_data: SpreadsheetUIStateData,
	year_grid: YearGrid,
	amount_entry_modal: AmountEntryModal,
) -> void:
	_spreadsheet_ui = spreadsheet_ui
	_state_data = state_data
	_year_grid = year_grid
	_amount_entry_modal = amount_entry_modal

func transition_state(
	new_state: SpreadsheetUI.State,
	state_data := SpreadsheetUIStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)
