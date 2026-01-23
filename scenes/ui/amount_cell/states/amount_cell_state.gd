class_name AmountCellState
extends Node

signal state_transition_requested(new_state: AmountCell.State, state_data: AmountCellStateData)

var _amount_cell: AmountCell = null
var _state_data: AmountCellStateData = null
var _appearance: AmountCellAppearance = null

func setup(
	amount_cell: AmountCell,
	state_data: AmountCellStateData,
	appearance: AmountCellAppearance,
) -> void:
	_amount_cell = amount_cell
	_state_data = state_data
	_appearance = appearance

func transition_state(
	new_state: AmountCell.State,
	state_data := AmountCellStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)

func dim() -> void:
	pass

func undim() -> void:
	pass

func highlight() -> void:
	pass

func unhighlight() -> void:
	pass

func inject_amount(amount: float) -> void:
	_appearance.set_amount(amount)

func is_highlighted() -> bool:
	return false
