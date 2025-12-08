class_name AmountEditAppearance
extends Node

@export
var amount_label: Label

func set_amount(amount: int) -> void:
	if amount_label:
		# TODO: pad with zeroes to the number of digits in the AmountEdit's
		# maximum amount
		amount_label.text = str(amount).pad_zeros(2)
