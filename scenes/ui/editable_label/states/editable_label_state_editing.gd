class_name EditableLabelStateEditing
extends EditableLabelState

func _enter_tree() -> void:
	Logger.debug("%s is now editing" % _editable_label.name)

	_editable_label.emit_activated()

	_appearance.for_editing()

	SignalHelper.persist(
		_line_edit.text_submitted,
		_on_text_submitted)

func _on_text_submitted(text: String) -> void:
	_editable_label.text = text

	_editable_label.emit_deactivated()

	transition_state(EditableLabel.State.HIGHLIGHTED)
