extends Node

@onready
var ctx_confirm_cancel: GUIDEMappingContext = preload("res://resources/input/ctx_confirm_cancel.tres")

@onready
var ctx_grid_movement: GUIDEMappingContext = preload("res://resources/input/ctx_grid_movement.tres")

@onready
var ctx_primary_modifier: GUIDEMappingContext = preload("res://resources/input/ctx_primary_modifier.tres")

func enable_confirm_cancel() -> void:
	GUIDE.enable_mapping_context(ctx_confirm_cancel)

func enable_grid_movement() -> void:
	GUIDE.enable_mapping_context(ctx_grid_movement)

func enable_primary_modifier() -> void:
	GUIDE.enable_mapping_context(ctx_primary_modifier)
