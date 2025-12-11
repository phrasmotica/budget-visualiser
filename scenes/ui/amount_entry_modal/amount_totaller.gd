class_name AmountTotaller
extends Node

@export
var edit_major: AmountEdit

@export
var edit_minor: AmountEdit

signal total_changed(total: float)

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
	var new_total := compute_total()
	total_changed.emit(new_total)

func _on_minor_changed(_amount: float) -> void:
	var new_total := compute_total()
	total_changed.emit(new_total)

func set_major(amount: int) -> void:
	if edit_major:
		edit_major.set_amount(amount)

func set_minor(amount: int) -> void:
	if edit_minor:
		edit_minor.set_amount(amount)

func compute_total() -> float:
	if edit_major and edit_minor:
		return edit_major.get_current_value() + 0.01 * edit_minor.get_current_value()

	return 0.0
