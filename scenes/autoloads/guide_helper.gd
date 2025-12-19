extends Node

@onready
var ctx_debugging: GUIDEMappingContext = preload("res://resources/input/ctx_debugging.tres")

func enable_debugging() -> void:
	GUIDE.enable_mapping_context(ctx_debugging)
