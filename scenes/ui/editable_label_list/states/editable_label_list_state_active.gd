class_name EditableLabelListStateActive
extends EditableLabelListState

func _enter_tree() -> void:
	Logger.debug("%s is now active" % _editable_label_list.name)
