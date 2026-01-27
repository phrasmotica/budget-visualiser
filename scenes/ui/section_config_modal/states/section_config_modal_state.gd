class_name SectionConfigModalState
extends Node

signal state_transition_requested(new_state: SectionConfigModal.State, state_data: SectionConfigModalStateData)

var _section_config_modal: SectionConfigModal = null
var _state_data: SectionConfigModalStateData = null

func setup(
	section_config_modal: SectionConfigModal,
	state_data: SectionConfigModalStateData,
) -> void:
	_section_config_modal = section_config_modal
	_state_data = state_data

func transition_state(
	new_state: SectionConfigModal.State,
	state_data := SectionConfigModalStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)
