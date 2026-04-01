class_name AmountCellStateEditing
extends AmountCellState

func _enter_tree() -> void:
	CustomLogger.debug("%s is now editing" % _amount_cell.name)
