@tool
class_name SectionConfigModalAppearance
extends Node

const MODULATE_COLOUR_ACTIVE := Color.WHITE
const MODULATE_COLOUR_PAUSE := Color.LIGHT_GRAY

@export
var modal: SectionConfigModal

@export
var header_label: Label

@export
var category_list: EditableLabelList

@export
var buttons: ModalButtons

func set_section(section: BudgetSection) -> void:
	if header_label:
		header_label.text = section.name if section else "<unknown>"

	# TODO: inject the category names into the label list

func for_active() -> void:
	if modal:
		modal.self_modulate = MODULATE_COLOUR_ACTIVE

	if header_label:
		header_label.self_modulate = MODULATE_COLOUR_ACTIVE

	if category_list:
		category_list.modulate = MODULATE_COLOUR_ACTIVE

	if buttons:
		buttons.self_modulate = MODULATE_COLOUR_ACTIVE

func for_paused() -> void:
	if modal:
		modal.self_modulate = MODULATE_COLOUR_PAUSE

	if header_label:
		header_label.self_modulate = MODULATE_COLOUR_PAUSE

	if buttons:
		buttons.self_modulate = MODULATE_COLOUR_PAUSE

func for_finishing() -> void:
	if category_list:
		category_list.modulate = MODULATE_COLOUR_PAUSE
