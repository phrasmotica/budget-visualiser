class_name SectionConfigModalState
extends Node

signal state_transition_requested(new_state: SectionConfigModal.State, state_data: SectionConfigModalStateData)

var _section_config_modal: SectionConfigModal = null
var _state_data: SectionConfigModalStateData = null
var _appearance: SectionConfigModalAppearance = null
var _category_list: EditableLabelList = null
var _modal_buttons: ModalButtons = null

func setup(
	section_config_modal: SectionConfigModal,
	state_data: SectionConfigModalStateData,
	appearance: SectionConfigModalAppearance,
	category_list: EditableLabelList,
	modal_buttons: ModalButtons,
) -> void:
	_section_config_modal = section_config_modal
	_state_data = state_data
	_appearance = appearance
	_category_list = category_list
	_modal_buttons = modal_buttons

func transition_state(
	new_state: SectionConfigModal.State,
	state_data := SectionConfigModalStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)

func enable() -> void:
	pass

func disable() -> void:
	pass
