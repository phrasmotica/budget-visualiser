class_name AmountEntryModalStateShown
extends AmountEntryModalState

func _enter_tree() -> void:
	print("%s is now shown" % _amount_entry_modal.name)

	_appearance.for_shown()

func _process(_delta: float) -> void:
	if Input.is_action_just_released("ui_focus_next"):
		_appearance.switch_amount_edits()
