extends Node

@onready
var action_grid_input: GUIDEAction = preload("res://resources/input/action_grid_input.tres")

signal move_end
signal move_start
signal move_bottom
signal move_top

func _ready() -> void:
	SignalHelper.persist(
		ModifierInput.primary_modifier_pressed,
		_on_primary_modifier_pressed
	)

	SignalHelper.persist(
		ModifierInput.primary_modifier_released,
		_on_primary_modifier_released
	)

func _on_primary_modifier_pressed() -> void:
	SignalHelper.persist(
		action_grid_input.triggered,
		_on_grid_input_triggered
	)

func _on_primary_modifier_released() -> void:
	SignalHelper.remove(
		action_grid_input.triggered,
		_on_grid_input_triggered
	)

func _on_grid_input_triggered() -> void:
	var value_2d := action_grid_input.value_axis_2d

	if value_2d == Vector2.RIGHT:
		move_end.emit()

	if value_2d == Vector2.LEFT:
		move_start.emit()

	if value_2d == Vector2.DOWN:
		move_bottom.emit()

	if value_2d == Vector2.UP:
		move_top.emit()
