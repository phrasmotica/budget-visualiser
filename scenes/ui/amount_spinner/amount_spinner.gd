@tool
class_name AmountSpinner
extends HBoxContainer

@onready
var edit_major: AmountEdit = %AmountEditMajor

@onready
var edit_minor: AmountEdit = %AmountEditMinor

signal amount_changed(amount: float)

func _ready() -> void:
	SignalHelper.persist(
		edit_major.amount_changed,
		_on_major_changed
	)

	SignalHelper.persist(
		edit_minor.amount_changed,
		_on_minor_changed
	)

func _on_major_changed(_amount: float) -> void:
	var new_amount := compute_amount()
	amount_changed.emit(new_amount)

func _on_minor_changed(_amount: float) -> void:
	var new_amount := compute_amount()
	amount_changed.emit(new_amount)

func compute_amount() -> float:
	if edit_major and edit_minor:
		return edit_major.get_current_value() + 0.01 * edit_minor.get_current_value()

	return 0.0

func reset_appearance() -> void:
	if edit_major:
		edit_major.enable()

	if edit_minor:
		edit_minor.disable()

func switch_amount_edits() -> void:
	# TODO: use one AmountEdit instance for each column of the amount
	# (10,000, 1,000, 100, 10, 1)

	if edit_major.is_enabled():
		edit_major.disable()
		edit_minor.enable()

	elif edit_minor.is_enabled():
		edit_major.enable()
		edit_minor.disable()

func set_amount(amount: float) -> void:
	if edit_major:
		var major_amount := int(amount)
		edit_major.set_amount(major_amount)

	if edit_minor:
		var minor_amount := int(100 * (amount - int(amount)))
		edit_minor.set_amount(minor_amount)
