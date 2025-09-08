@tool
class_name MonthGridAppearance
extends Node

@export
var name_label: Label

func set_month_name(month_name: String) -> void:
	if name_label:
		name_label.text = month_name
