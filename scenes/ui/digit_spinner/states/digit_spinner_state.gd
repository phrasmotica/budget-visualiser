class_name DigitSpinnerState
extends Node

signal state_transition_requested(new_state: DigitSpinner.State, state_data: DigitSpinnerStateData)

var _digit_spinner: DigitSpinner = null
var _state_data: DigitSpinnerStateData = null
var _appearance: DigitSpinnerAppearance = null

func setup(
	digit_spinner: DigitSpinner,
	state_data: DigitSpinnerStateData,
	appearance: DigitSpinnerAppearance,
) -> void:
	_digit_spinner = digit_spinner
	_state_data = state_data
	_appearance = appearance

func transition_state(
	new_state: DigitSpinner.State,
	state_data := DigitSpinnerStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)

func highlight() -> void:
	pass

func unhighlight() -> void:
	pass
