class_name EditableLabelState
extends Node

signal state_transition_requested(new_state: EditableLabel.State, state_data: EditableLabelStateData)

var _editable_label: EditableLabel = null
var _state_data: EditableLabelStateData = null
var _appearance: EditableLabelAppearance = null
var _line_edit: LineEdit = null

func setup(
	editable_label: EditableLabel,
	state_data: EditableLabelStateData,
	appearance: EditableLabelAppearance,
	line_edit: LineEdit,
) -> void:
	_editable_label = editable_label
	_state_data = state_data
	_appearance = appearance
	_line_edit = line_edit

func transition_state(
	new_state: EditableLabel.State,
	state_data := EditableLabelStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)
