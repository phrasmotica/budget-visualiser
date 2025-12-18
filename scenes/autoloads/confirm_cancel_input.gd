extends Node

@onready
var action_confirm: GUIDEAction = preload("res://resources/input/action_confirm.tres")

@onready
var action_cancel: GUIDEAction = preload("res://resources/input/action_cancel.tres")

signal confirm
signal cancel

func _ready() -> void:
	SignalHelper.chain(action_confirm.triggered, confirm)
	SignalHelper.chain(action_cancel.triggered, cancel)
