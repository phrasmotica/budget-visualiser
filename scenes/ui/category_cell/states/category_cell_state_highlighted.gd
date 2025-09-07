class_name CategoryCellStateHighlighted
extends CategoryCellState

func _enter_tree() -> void:
	print("%s is now highlighted" % _category_cell.name)

	_category_cell.theme_type_variation = "HighlightedPanelContainer"
