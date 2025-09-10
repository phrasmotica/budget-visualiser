class_name AmountEntryModalStateHidden
extends AmountEntryModalState

func _enter_tree() -> void:
	print("%s is now hidden" % _amount_entry_modal.name)

	_amount_entry_modal.hide()

func enable() -> void:
	transition_state(AmountEntryModal.State.SHOWN)
