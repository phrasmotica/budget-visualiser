class_name EditableLabelListState
extends Node

signal state_transition_requested(new_state: EditableLabelList.State, state_data: EditableLabelListStateData)

var _editable_label_list: EditableLabelList = null
var _state_data: EditableLabelListStateData = null
var _label_manager: EditableLabelManager = null

func setup(
	editable_label_list: EditableLabelList,
	state_data: EditableLabelListStateData,
	label_manager: EditableLabelManager,
) -> void:
	_editable_label_list = editable_label_list
	_state_data = state_data
	_label_manager = label_manager

func transition_state(
	new_state: EditableLabelList.State,
	state_data := EditableLabelListStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)

func activate() -> void:
	pass
