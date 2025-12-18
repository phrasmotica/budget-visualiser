@tool
class_name HeaderPanel
extends PanelContainer

@export
var text := "":
	set(value):
		text = value

		_refresh()

# TODO: only show the icons when the Ctrl/Cmd key is held down. Create a new
# autoload for handling modifier input on a per-OS basis...
@export
var show_icons := false:
	set(value):
		show_icons = value

		_refresh()

@onready
var label: Label = %Label

@onready
var left_icon: TextureRect = %LeftIcon

@onready
var right_icon: TextureRect = %RightIcon

func _ready() -> void:
	_refresh()

func _refresh() -> void:
	if label:
		label.text = text

	if left_icon:
		left_icon.visible = show_icons

	if right_icon:
		right_icon.visible = show_icons
