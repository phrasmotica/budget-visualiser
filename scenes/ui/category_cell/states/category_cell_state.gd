class_name CategoryCellState
extends Node

signal state_transition_requested(new_state: CategoryCell.State, state_data: CategoryCellStateData)

var _category_cell: CategoryCell = null
var _state_data: CategoryCellStateData = null
var _appearance: CategoryCellAppearance = null

func setup(
	category_cell: CategoryCell,
	state_data: CategoryCellStateData,
	appearance: CategoryCellAppearance,
) -> void:
	_category_cell = category_cell
	_state_data = state_data
	_appearance = appearance

func transition_state(
	new_state: CategoryCell.State,
	state_data := CategoryCellStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)

func dim() -> void:
	pass

func highlight() -> void:
	pass

func unhighlight() -> void:
	pass

func inject_amount(amount: float) -> void:
	_appearance.set_amount(amount)

func is_highlighted() -> bool:
	return false
