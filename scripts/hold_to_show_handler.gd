@tool
class_name HoldToShowHandler extends Node

@export
var input: StringName = "":
	set(value):
		input = value
		update_configuration_warnings()

@export_range(1.0, 3.0)
var duration: float = 1

@export
var control_to_show: Control

@export
var disabled := false:
	set(value):
		disabled = value

		if disabled:
			cancel_timer()

var input_exists := false
var _timer: SceneTreeTimer

signal activated
signal deactivated

func _ready():
	if Engine.is_editor_hint():
		InputMap.load_from_project_settings()
		return

	input_exists = InputMap.has_action(input)

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		return

	if not disabled and input_exists:
		handle_hold_to_show()

func _get_configuration_warnings() -> PackedStringArray:
	if not InputMap.has_action(input):
		return ["The input '%s' does not exist!" % input]

	return []

func handle_hold_to_show() -> void:
	if Input.is_action_just_pressed(input):
		_timer = get_tree().create_timer(duration)

		print("Starting %s timer" % input)

		_timer.timeout.connect(
			func():
				if Input.is_action_pressed(input):
					print("Activating %s from timer" % input)

					control_to_show.show()
					activated.emit()
		)

	if Input.is_action_just_released(input):
		if control_to_show.visible:
			control_to_show.hide()

		cancel_timer()

		deactivated.emit()

func cancel_timer():
	if _timer:
		print("Cancelling %s timer" % input)

		var connections := _timer.timeout.get_connections()
		for c in connections:
			_timer.timeout.disconnect(c["callable"])

func _on_ui_modal_shown() -> void:
	disabled = true

func _on_ui_modal_hidden() -> void:
	disabled = false
