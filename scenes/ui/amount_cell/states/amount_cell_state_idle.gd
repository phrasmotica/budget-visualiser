class_name AmountCellStateIdle
extends AmountCellState

func _enter_tree() -> void:
	Logger.debug("%s is now idle" % _amount_cell.name)

	_amount_cell.theme_type_variation = "IdlePanelContainer"

func dim() -> void:
	transition_state(AmountCell.State.DIMMED)

func highlight() -> void:
	transition_state(AmountCell.State.HIGHLIGHTED)
