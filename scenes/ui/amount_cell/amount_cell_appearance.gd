class_name AmountCellAppearance
extends Node

@export
var amount_label: AmountLabel

func set_amount(amount: float) -> void:
	if amount_label:
		amount_label.amount = amount
