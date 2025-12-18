extends Node

var _is_windows := false
var _is_macos := false

signal primary_modifier_pressed
signal primary_modifier_released

func _ready() -> void:
	var os_helper := OSHelper.new()

	_is_windows = os_helper.is_windows()
	_is_macos = os_helper.is_macos()

	set_process(_is_windows or _is_macos)

func _process(_delta: float) -> void:
	if _is_windows:
		if Input.is_action_just_pressed("primary_modifier_windows"):
			primary_modifier_pressed.emit()

		if Input.is_action_just_released("primary_modifier_windows"):
			primary_modifier_released.emit()

	if _is_macos:
		if Input.is_action_just_pressed("primary_modifier_macos"):
			primary_modifier_pressed.emit()

		if Input.is_action_just_released("primary_modifier_macos"):
			primary_modifier_released.emit()
