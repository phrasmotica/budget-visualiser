class_name SpreadsheetUIState
extends Node

signal state_transition_requested(new_state: SpreadsheetUI.State, state_data: SpreadsheetUIStateData)

var _spreadsheet_ui: SpreadsheetUI = null
var _state_data: SpreadsheetUIStateData = null

func setup(
	spreadsheet_ui: SpreadsheetUI,
	state_data: SpreadsheetUIStateData,
) -> void:
	_spreadsheet_ui = spreadsheet_ui
	_state_data = state_data

func transition_state(
	new_state: SpreadsheetUI.State,
	state_data := SpreadsheetUIStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)
