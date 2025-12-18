extends Node

@onready
var action_grid_input: GUIDEAction = preload("res://resources/input/action_grid_input.tres")

signal move_right
signal move_left
signal move_down
signal move_up

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
	SignalHelper.remove(
		action_grid_input.triggered,
		_on_grid_input_triggered
	)

func _on_primary_modifier_released() -> void:
	SignalHelper.persist(
		action_grid_input.triggered,
		_on_grid_input_triggered
	)

func _on_grid_input_triggered() -> void:
	var value_2d := action_grid_input.value_axis_2d

	if value_2d == Vector2.RIGHT:
		move_right.emit()

	if value_2d == Vector2.LEFT:
		move_left.emit()

	if value_2d == Vector2.DOWN:
		move_down.emit()

	if value_2d == Vector2.UP:
		move_up.emit()
