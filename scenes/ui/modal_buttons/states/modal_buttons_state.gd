class_name ModalButtonsState
extends Node

signal state_transition_requested(new_state: ModalButtons.State, state_data: ModalButtonsStateData)

var _modal_buttons: ModalButtons = null
var _state_data: ModalButtonsStateData = null
var _finished_button: ButtonPanel = null

func setup(
	modal_buttons: ModalButtons,
	state_data: ModalButtonsStateData,
	finished_button: ButtonPanel,
) -> void:
	_modal_buttons = modal_buttons
	_state_data = state_data
	_finished_button = finished_button

func transition_state(
	new_state: ModalButtons.State,
	state_data := ModalButtonsStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)

func activate() -> void:
	pass

func deactivate() -> void:
	pass
