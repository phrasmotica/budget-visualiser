class_name EditableLabelStateEditing
extends EditableLabelState

func _enter_tree() -> void:
	Logger.debug("%s is now editing" % _editable_label.name)

	_appearance.for_editing()

	SignalHelper.persist(
		_line_edit.text_submitted,
		_on_text_submitted)

func _on_text_submitted(text: String) -> void:
	_appearance.set_label_text(text)

	# TODO: emit the new text in a signal, so a parent node can use it...

	transition_state(EditableLabel.State.IDLE)
