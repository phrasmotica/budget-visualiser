class_name CategoryCellStateIdle
extends CategoryCellState

func _enter_tree() -> void:
	print("%s is now idle" % _category_cell.name)

	_category_cell.theme_type_variation = "IdlePanelContainer"

func dim() -> void:
	transition_state(CategoryCell.State.DIMMED)

func highlight() -> void:
	transition_state(CategoryCell.State.HIGHLIGHTED)
