extends Node

@onready
var action_toggle_guide_debugger: GUIDEAction = preload("res://resources/input/action_toggle_guide_debugger.tres")

signal toggle_guide_debugger_pressed

func _ready() -> void:
	SignalHelper.chain(
		action_toggle_guide_debugger.triggered,
		toggle_guide_debugger_pressed
	)
