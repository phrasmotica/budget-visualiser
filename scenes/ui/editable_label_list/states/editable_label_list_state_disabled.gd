class_name EditableLabelListStateDisabled
extends EditableLabelListState

func _enter_tree() -> void:
	Logger.debug("%s is now disabled" % _editable_label_list.name)

	# TODO: dim all of the labels that aren't being edited. Create a new state
	# for EditableLabel so that this can happen, maybe called DISABLED...

	SignalHelper.persist(
		_label_manager.label_deactivated,
		_on_label_deactivated
	)

func _on_label_deactivated() -> void:
	_editable_label_list.emit_enabled()

	transition_state(EditableLabelList.State.ACTIVE)
