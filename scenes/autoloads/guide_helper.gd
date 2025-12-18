extends Node

@onready
var ctx_primary_modifier: GUIDEMappingContext = preload("res://resources/input/ctx_primary_modifier.tres")

@onready
var ctx_grid_movement: GUIDEMappingContext = preload("res://resources/input/ctx_grid_movement.tres")

func enable_primary_modifier() -> void:
	GUIDE.enable_mapping_context(ctx_primary_modifier)

func enable_grid_movement() -> void:
	GUIDE.enable_mapping_context(ctx_grid_movement)
