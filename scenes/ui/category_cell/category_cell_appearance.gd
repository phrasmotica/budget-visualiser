class_name CategoryCellAppearance
extends Node

@export
var amount_label: Label

func set_amount(amount: float) -> void:
	if amount_label:
		amount_label.text = "£%.2f" % amount
