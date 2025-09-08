class_name CategoryCellStateDimmed
extends CategoryCellState

func _enter_tree() -> void:
	print("%s is now dimmed" % _category_cell.name)

	_category_cell.theme_type_variation = "DimmedCategoryCellContainer"

func highlight() -> void:
	transition_state(CategoryCell.State.HIGHLIGHTED)
