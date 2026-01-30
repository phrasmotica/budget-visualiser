@tool
class_name EditableLabelAppearance
extends Node

const MODULATE_COLOUR_IDLE := Color.WHITE
const MODULATE_COLOUR_DISABLED := Color.LIGHT_GRAY

@export
var idle_container: PanelContainer

@export
var label: Label

@export
var editing_container: PanelContainer

@export
var line_edit: LineEdit

func set_label_text(text: String) -> void:
	if label:
		label.text = text

func set_line_edit_text(text: String) -> void:
	if line_edit:
		line_edit.text = text

func copy_label_text_to_line_edit() -> void:
	if label:
		set_line_edit_text(label.text)

func for_idle() -> void:
	if idle_container:
		idle_container.show()
		idle_container.theme_type_variation = "EmptyPanelContainer"

		idle_container.modulate = MODULATE_COLOUR_IDLE

	if editing_container:
		editing_container.hide()

	if not Engine.is_editor_hint():
		if line_edit:
			line_edit.editable = false
			line_edit.release_focus()

func for_highlighted() -> void:
	if idle_container:
		idle_container.show()
		idle_container.theme_type_variation = "EditableLabelPanelContainer"

	if editing_container:
		editing_container.hide()

	if not Engine.is_editor_hint():
		if line_edit:
			line_edit.editable = false
			line_edit.release_focus()

func for_editing() -> void:
	if idle_container:
		idle_container.hide()

	if editing_container:
		editing_container.show()

	if not Engine.is_editor_hint():
		if line_edit:
			line_edit.editable = true
			line_edit.grab_focus()

			line_edit.select_all()
			line_edit.caret_column = line_edit.text.length()

func for_disabled() -> void:
	if idle_container:
		idle_container.show()
		idle_container.theme_type_variation = "EmptyPanelContainer"

		idle_container.modulate = MODULATE_COLOUR_DISABLED

	if editing_container:
		editing_container.hide()
