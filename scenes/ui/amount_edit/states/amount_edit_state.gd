class_name AmountEditState
extends Node

signal state_transition_requested(new_state: AmountEdit.State, state_data: AmountEditStateData)

var _amount_edit: AmountEdit = null
var _state_data: AmountEditStateData = null
var _appearance: AmountEditAppearance = null
var _amount_tracker: AmountTracker = null

func setup(
	amount_edit: AmountEdit,
	state_data: AmountEditStateData,
	appearance: AmountEditAppearance,
	amount_tracker: AmountTracker,
) -> void:
	_amount_edit = amount_edit
	_state_data = state_data
	_appearance = appearance
	_amount_tracker = amount_tracker

func transition_state(
	new_state: AmountEdit.State,
	state_data := AmountEditStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)

func enable() -> void:
	pass

func disable() -> void:
	pass

func is_enabled() -> bool:
	return false
