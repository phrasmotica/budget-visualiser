extends Node

@onready
var action_toggle_summary: GUIDEAction = preload(
	"res://resources/input/action_toggle_summary.tres")

signal toggle_summary_requested

func _ready() -> void:
	SignalHelper.chain(
		action_toggle_summary.triggered,
		toggle_summary_requested)
