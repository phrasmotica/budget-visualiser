@tool
class_name HeaderPanel
extends PanelContainer

@export
var text := "":
	set(value):
		text = value

		_refresh()

@onready
var label: Label = %Label

func _ready() -> void:
	_refresh()

func _refresh() -> void:
	if label:
		label.text = text
