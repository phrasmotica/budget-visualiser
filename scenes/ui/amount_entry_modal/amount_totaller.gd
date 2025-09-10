class_name AmountTotaller
extends Node

@export
var edit_major: AmountEdit

@export
var edit_minor: AmountEdit

func compute_total() -> float:
	if edit_major and edit_minor:
		return edit_major.get_current_value() + 0.01 * edit_minor.get_current_value()

	return 0.0
