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
var ctx_modifiers: GUIDEMappingContext = preload("res://resources/input/ctx_modifiers.tres")

@onready
var ctx_transaction_lister_modal_acting: GUIDEMappingContext = preload(
	"res://resources/input/ctx_transaction_lister_modal_acting.tres")

@onready
var ctx_modal_buttons: GUIDEMappingContext = preload(
	"res://resources/input/ctx_modal_buttons.tres")

func enable_confirm_cancel() -> void:
	GUIDE.enable_mapping_context(ctx_confirm_cancel)

func enable_debugging() -> void:
	GUIDE.enable_mapping_context(ctx_debugging)

func enable_grid_movement() -> void:
	GUIDE.enable_mapping_context(ctx_grid_movement)

func disable_grid_movement() -> void:
	GUIDE.disable_mapping_context(ctx_grid_movement)

func enable_modals() -> void:
	GUIDE.enable_mapping_context(ctx_modals)

func disable_modals() -> void:
	GUIDE.disable_mapping_context(ctx_modals)

func enable_modifiers() -> void:
	GUIDE.enable_mapping_context(ctx_modifiers)

func enable_transaction_lister_modal_acting() -> void:
	GUIDE.enable_mapping_context(ctx_transaction_lister_modal_acting)

func disable_transaction_lister_modal_acting() -> void:
	GUIDE.disable_mapping_context(ctx_transaction_lister_modal_acting)

func enable_modal_buttons() -> void:
	GUIDE.enable_mapping_context(ctx_modal_buttons)

func disable_modal_buttons() -> void:
	GUIDE.disable_mapping_context(ctx_modal_buttons)
