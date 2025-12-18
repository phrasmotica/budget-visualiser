extends Node

@onready
var action_primary_modifier_windows: GUIDEAction = preload("res://resources/input/action_primary_modifier_windows.tres")

@onready
var action_primary_modifier_macos: GUIDEAction = preload("res://resources/input/action_primary_modifier_macos.tres")

signal primary_modifier_pressed
signal primary_modifier_released

func _ready() -> void:
	var os_helper := OSHelper.new()

	if os_helper.is_windows():
		SignalHelper.persist(
			action_primary_modifier_windows.triggered,
			_on_action_primary_modifier_triggered.bind(action_primary_modifier_windows)
		)

	if os_helper.is_macos():
		SignalHelper.persist(
			action_primary_modifier_macos.triggered,
			_on_action_primary_modifier_triggered.bind(action_primary_modifier_macos)
		)

func _on_action_primary_modifier_triggered(action: GUIDEAction) -> void:
	var value_bool := action.value_bool

	if value_bool:
		primary_modifier_pressed.emit()
	else:
		primary_modifier_released.emit()
