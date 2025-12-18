extends Node

@onready
var action_grid_input: GUIDEAction = preload("res://resources/input/action_grid_input.tres")

var _is_primary_modifier_pressed := false

signal move_end
signal move_right
signal move_start
signal move_left
signal move_down
signal move_bottom
signal move_up
signal move_top

# TODO: create a new autoload for handling move_end, move_start, move_bottom and move_top...

func _ready() -> void:
	SignalHelper.persist(
		ModifierInput.primary_modifier_pressed,
		_on_primary_modifier_pressed
	)

	SignalHelper.persist(
		ModifierInput.primary_modifier_released,
		_on_primary_modifier_released
	)

	SignalHelper.persist(
		action_grid_input.triggered,
		_on_grid_input_triggered
	)

func _on_primary_modifier_pressed() -> void:
	_is_primary_modifier_pressed = true

func _on_primary_modifier_released() -> void:
	_is_primary_modifier_pressed = false

func _on_grid_input_triggered() -> void:
	var value_2d := action_grid_input.value_axis_2d

	if value_2d == Vector2.RIGHT:
		if _is_primary_modifier_pressed:
			move_end.emit()
		else:
			move_right.emit()

	if value_2d == Vector2.LEFT:
		if _is_primary_modifier_pressed:
			move_start.emit()
		else:
			move_left.emit()

	if value_2d == Vector2.DOWN:
		if _is_primary_modifier_pressed:
			move_bottom.emit()
		else:
			move_down.emit()

	if value_2d == Vector2.UP:
		if _is_primary_modifier_pressed:
			move_top.emit()
		else:
			move_up.emit()
