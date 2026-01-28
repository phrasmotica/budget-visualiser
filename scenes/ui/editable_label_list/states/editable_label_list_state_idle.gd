class_name EditableLabelListStateIdle
extends EditableLabelListState

func _enter_tree() -> void:
	Logger.debug("%s is now idle" % _editable_label_list.name)
