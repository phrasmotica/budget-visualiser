class_name ModalButtonsState
extends Node

signal state_transition_requested(new_state: ModalButtons.State, state_data: ModalButtonsStateData)

var _modal_buttons: ModalButtons = null
var _state_data: ModalButtonsStateData = null
var _button_manager: ButtonManager = null

func setup(
	modal_buttons: ModalButtons,
	state_data: ModalButtonsStateData,
	button_manager: ButtonManager,
) -> void:
	_modal_buttons = modal_buttons
	_state_data = state_data
	_button_manager = button_manager

func transition_state(
	new_state: ModalButtons.State,
	state_data := ModalButtonsStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)

func activate() -> void:
	pass

func deactivate() -> void:
	pass
