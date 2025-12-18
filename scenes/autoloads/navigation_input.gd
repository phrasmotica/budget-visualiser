extends Node

@onready
var action_next_section: GUIDEAction = preload("res://resources/input/action_next_section.tres")

signal next_section

func _ready() -> void:
	SignalHelper.chain(action_next_section.triggered, next_section)
