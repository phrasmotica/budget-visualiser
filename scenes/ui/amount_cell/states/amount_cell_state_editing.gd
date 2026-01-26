class_name AmountCellStateEditing
extends AmountCellState

func _enter_tree() -> void:
	Logger.debug("%s is now editing" % _amount_cell.name)
