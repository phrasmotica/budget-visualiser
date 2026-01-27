class_name EditableLabelStateIdle
extends EditableLabelState

func _enter_tree() -> void:
	Logger.debug("%s is now idle" % _editable_label.name)

	_appearance.for_idle()

func highlight() -> void:
	transition_state(EditableLabel.State.HIGHLIGHTED)
