class_name EditableLabelStateDisabled
extends EditableLabelState

func _enter_tree() -> void:
	Logger.debug("%s is now disabled" % _editable_label.name)

	_appearance.for_disabled()

func enable() -> void:
	transition_state(EditableLabel.State.IDLE)
