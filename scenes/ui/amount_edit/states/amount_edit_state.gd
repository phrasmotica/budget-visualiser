class_name AmountEditState
extends Node

signal state_transition_requested(new_state: AmountEdit.State, state_data: AmountEditStateData)

var _amount_edit: AmountEdit = null
var _state_data: AmountEditStateData = null

func setup(
	amount_edit: AmountEdit,
	state_data: AmountEditStateData,
) -> void:
	_amount_edit = amount_edit
	_state_data = state_data

func transition_state(
	new_state: AmountEdit.State,
	state_data := AmountEditStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)
