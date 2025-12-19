extends Node

@onready
var ctx_confirm_cancel: GUIDEMappingContext = preload("res://resources/input/ctx_confirm_cancel.tres")

@onready
var ctx_debugging: GUIDEMappingContext = preload("res://resources/input/ctx_debugging.tres")

@onready
var ctx_grid_movement: GUIDEMappingContext = preload("res://resources/input/ctx_grid_movement.tres")

@onready
var ctx_modals: GUIDEMappingContext = preload("res://resources/input/ctx_modals.tres")

@onready
var ctx_navigation: GUIDEMappingContext = preload("res://resources/input/ctx_navigation.tres")

@onready
var ctx_modifiers: GUIDEMappingContext = preload("res://resources/input/ctx_modifiers.tres")

func enable_confirm_cancel() -> void:
	GUIDE.enable_mapping_context(ctx_confirm_cancel)

func enable_debugging() -> void:
	GUIDE.enable_mapping_context(ctx_debugging)

func enable_grid_movement() -> void:
	GUIDE.enable_mapping_context(ctx_grid_movement)

func enable_modals() -> void:
	GUIDE.enable_mapping_context(ctx_modals)

func disable_modals() -> void:
	GUIDE.disable_mapping_context(ctx_modals)

func enable_navigation() -> void:
	GUIDE.enable_mapping_context(ctx_navigation)

func disable_navigation() -> void:
	GUIDE.disable_mapping_context(ctx_navigation)

func enable_modifiers() -> void:
	GUIDE.enable_mapping_context(ctx_modifiers)
