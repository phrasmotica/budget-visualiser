class_name DigitSpinnerState
extends Node

signal state_transition_requested(new_state: DigitSpinner.State, state_data: DigitSpinnerStateData)

var _digit_spinner: DigitSpinner = null
var _state_data: DigitSpinnerStateData = null
var _appearance: DigitSpinnerAppearance = null
var _amount_tracker: AmountTracker = null

func setup(
	digit_spinner: DigitSpinner,
	state_data: DigitSpinnerStateData,
	appearance: DigitSpinnerAppearance,
	amount_tracker: AmountTracker,
) -> void:
	_digit_spinner = digit_spinner
	_state_data = state_data
	_appearance = appearance
	_amount_tracker = amount_tracker

func transition_state(
	new_state: DigitSpinner.State,
	state_data := DigitSpinnerStateData.new(),
) -> void:
	state_transition_requested.emit(new_state, state_data)
