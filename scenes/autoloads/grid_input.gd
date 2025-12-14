extends Node

signal move_right
signal move_left
signal move_down
signal move_bottom
signal move_up
signal move_top

func _process(_delta: float) -> void:
	if Input.is_action_just_released("ui_right"):
		emit_move_right()

	if Input.is_action_just_released("ui_left"):
		emit_move_left()

	if Input.is_action_just_released("nav_bottom"):
		emit_move_bottom()
	elif Input.is_action_just_released("ui_down"):
		emit_move_down()

	if Input.is_action_just_released("nav_top"):
		emit_move_top()
	elif Input.is_action_just_released("ui_up"):
		emit_move_up()

func emit_move_right() -> void:
	move_right.emit()

func emit_move_left() -> void:
	move_left.emit()

func emit_move_down() -> void:
	move_down.emit()

func emit_move_bottom() -> void:
	move_bottom.emit()

func emit_move_up() -> void:
	move_up.emit()

func emit_move_top() -> void:
	move_top.emit()
