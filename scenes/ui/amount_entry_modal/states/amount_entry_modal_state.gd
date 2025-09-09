class_name AmountEntryModalState
extends Node

signal state_transition_requested(new_state: AmountEntryModal.State, state_data: AmountEntryModalStateData)

var _amount_entry_modal: AmountEntryModal = null
var _state_data: AmountEntryModalStateData = null

func setup(
	amount_entry_modal: AmountEntryModal,
	state_data: AmountEntryModalStateData,
) -> void:
	_amount_entry_modal = amount_entry_modal
	_state_data = state_data

func transition_state(
	new_state: AmountEntryModal.State,
	state_data := AmountEntryModalStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)
