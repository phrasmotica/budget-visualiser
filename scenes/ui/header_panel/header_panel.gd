@tool
class_name HeaderPanel
extends PanelContainer

@export
var text := "":
	set(value):
		text = value

		_refresh()

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

	SignalHelper.persist(
		ModifierInput.primary_modifier_pressed,
		_on_primary_modifier_pressed
	)

	SignalHelper.persist(
		ModifierInput.primary_modifier_released,
		_on_primary_modifier_released
	)

func _on_primary_modifier_pressed() -> void:
	show_icons = true

func _on_primary_modifier_released() -> void:
	show_icons = false

func _refresh() -> void:
	if label:
		label.text = text

	if left_icon:
		left_icon.visible = show_icons

	if right_icon:
		right_icon.visible = show_icons
