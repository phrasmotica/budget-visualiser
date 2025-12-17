class_name ButtonPanelState
extends Node

signal state_transition_requested(new_state: ButtonPanel.State, state_data: ButtonPanelStateData)

var _button_panel: ButtonPanel = null
var _state_data: ButtonPanelStateData = null

func setup(
	button_panel: ButtonPanel,
	state_data: ButtonPanelStateData,
) -> void:
	_button_panel = button_panel
	_state_data = state_data

func transition_state(
	new_state: ButtonPanel.State,
	state_data := ButtonPanelStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)

func highlight() -> void:
	pass

func unhighlight() -> void:
	pass
