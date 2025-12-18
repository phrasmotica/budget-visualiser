class_name CategoryCellStateHighlighted
extends CategoryCellState

func _enter_tree() -> void:
	Logger.debug("%s is now highlighted" % _category_cell.name)

	_category_cell.theme_type_variation = "HighlightedPanelContainer"

func dim() -> void:
	transition_state(CategoryCell.State.DIMMED)

func unhighlight() -> void:
	transition_state(CategoryCell.State.IDLE)

func is_highlighted() -> bool:
	return true
