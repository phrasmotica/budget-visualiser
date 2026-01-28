class_name EditableLabelListStateDisabled
extends EditableLabelListState

func _enter_tree() -> void:
	Logger.debug("%s is now disabled" % _editable_label_list.name)

	SignalHelper.persist(
		_label_manager.label_deactivated,
		_on_label_deactivated
	)

func _on_label_deactivated() -> void:
	transition_state(EditableLabelList.State.ACTIVE)
