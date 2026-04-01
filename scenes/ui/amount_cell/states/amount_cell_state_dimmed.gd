class_name AmountCellStateDimmed
extends AmountCellState

func _enter_tree() -> void:
	CustomLogger.debug("%s is now dimmed" % _amount_cell.name)

	_amount_cell.theme_type_variation = "DimmedAmountCellContainer"

func undim() -> void:
	transition_state(AmountCell.State.IDLE)

func highlight() -> void:
	transition_state(AmountCell.State.HIGHLIGHTED)
