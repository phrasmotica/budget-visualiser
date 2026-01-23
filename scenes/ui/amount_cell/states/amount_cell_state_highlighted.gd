class_name AmountCellStateHighlighted
extends AmountCellState

func _enter_tree() -> void:
	Logger.debug("%s is now highlighted" % _amount_cell.name)

	_amount_cell.theme_type_variation = "HighlightedPanelContainer"

func dim() -> void:
	transition_state(AmountCell.State.DIMMED)

func unhighlight() -> void:
	transition_state(AmountCell.State.IDLE)

func is_highlighted() -> bool:
	return true
