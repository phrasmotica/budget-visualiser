class_name CategoryCellStateIdle
extends CategoryCellState

func _enter_tree() -> void:
	print("%s is now idle" % _category_cell.name)

	_category_cell.theme_type_variation = "IdlePanelContainer"
