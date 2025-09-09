class_name AmountEditAppearance
extends Node

@export
var amount_label: Label

func set_amount(amount: int) -> void:
	if amount_label:
		amount_label.text = str(amount).pad_zeros(2)
