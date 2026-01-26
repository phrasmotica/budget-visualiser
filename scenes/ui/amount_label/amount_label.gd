@tool
class_name AmountLabel
extends MarginContainer

@export
var amount := 0.0:
	set(value):
		amount = value

		_refresh()

@export
var show_as_hidden := false:
	set(value):
		show_as_hidden = value

		_refresh()

@export
var show_as_unknown := false:
	set(value):
		show_as_unknown = value

		_refresh()

@onready
var label: Label = %Label

func _ready() -> void:
	_refresh()

func _refresh() -> void:
	if label:
		if show_as_unknown:
			label.text = "???"
		else:
			label.text = Strings.curr(amount)

		if show_as_hidden:
			label.label_settings.font_color = Color.DIM_GRAY
		else:
			label.label_settings.font_color = Color.WHITE
