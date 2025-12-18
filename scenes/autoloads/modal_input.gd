extends Node

@onready
var action_show_transaction_lister_modal: GUIDEAction = preload(
	"res://resources/input/action_show_transaction_lister_modal.tres")

signal transaction_lister_modal_requested

func _ready() -> void:
	SignalHelper.chain(
		action_show_transaction_lister_modal.triggered,
		transaction_lister_modal_requested)
