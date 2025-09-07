class_name CategoryCellState
extends Node

signal state_transition_requested(new_state: CategoryCell.State, state_data: CategoryCellStateData)

var _category_cell: CategoryCell = null
var _state_data: CategoryCellStateData = null

func setup(
	category_cell: CategoryCell,
	state_data: CategoryCellStateData,
) -> void:
	_category_cell = category_cell
	_state_data = state_data

func transition_state(
	new_state: CategoryCell.State,
	state_data := CategoryCellStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)
