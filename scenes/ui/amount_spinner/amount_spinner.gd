@tool
class_name AmountSpinner
extends PanelContainer

@export
var columns := 4:
	set(value):
		columns = value

		_refresh()

@onready
var digit_spinner_manager: DigitSpinnerManager = %DigitSpinnerManager

signal amount_changed(amount: float)

func _ready() -> void:
	# SignalHelper.persist(
	# 	edit_major.amount_changed,
	# 	_on_major_changed
	# )

	# SignalHelper.persist(
	# 	edit_minor.amount_changed,
	# 	_on_minor_changed
	# )

	# TODO: implement
	pass

func _refresh() -> void:
	if digit_spinner_manager:
		digit_spinner_manager.refresh_spinners(self, columns)

func _on_major_changed(_amount: float) -> void:
	var new_amount := compute_amount()
	amount_changed.emit(new_amount)

func _on_minor_changed(_amount: float) -> void:
	var new_amount := compute_amount()
	amount_changed.emit(new_amount)

func compute_amount() -> float:
	# if edit_major and edit_minor:
	# 	return edit_major.get_current_value() + 0.01 * edit_minor.get_current_value()

	# TODO: implement
	return 0.0

func reset_appearance() -> void:
	# if edit_major:
	# 	edit_major.enable()

	# if edit_minor:
	# 	edit_minor.disable()

	# TODO: implement
	pass

func switch_amount_edits() -> void:
	# TODO: use one AmountEdit instance for each column of the amount
	# (10,000, 1,000, 100, 10, 1)

	# if edit_major.is_enabled():
	# 	edit_major.disable()
	# 	edit_minor.enable()

	# elif edit_minor.is_enabled():
	# 	edit_major.enable()
	# 	edit_minor.disable()

	# TODO: implement
	pass

func set_amount(_amount: float) -> void:
	# if edit_major:
	# 	var major_amount := int(amount)
	# 	edit_major.set_amount(major_amount)

	# if edit_minor:
	# 	var minor_amount := int(100 * (amount - int(amount)))
	# 	edit_minor.set_amount(minor_amount)

	# TODO: implement
	pass
