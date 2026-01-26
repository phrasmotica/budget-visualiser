@tool
class_name AmountSpinner
extends PanelContainer

@export
var amount := 0.0:
	set(value):
		amount = maxf(value, 0.0)

		_refresh()

@export
var columns := 4:
	set(value):
		columns = maxi(value, 3)

		_refresh()

@onready
var digit_spinner_manager: DigitSpinnerManager = %DigitSpinnerManager

signal amount_changed(amount: float)

func _ready() -> void:
	SignalHelper.chain(
		digit_spinner_manager.amount_changed,
		amount_changed)

	_refresh()

func _refresh() -> void:
	if digit_spinner_manager:
		digit_spinner_manager.set_amount(amount)
		digit_spinner_manager.refresh_all_spinners(self, columns - 2, 2)

func compute_amount() -> float:
	return digit_spinner_manager.get_amount()

func reset_appearance() -> void:
	digit_spinner_manager.reset_appearance()

func next_column() -> void:
	digit_spinner_manager.next_column()

func previous_column() -> void:
	digit_spinner_manager.previous_column()
