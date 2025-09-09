class_name AmountEditStateIdle
extends AmountEditState

func _enter_tree() -> void:
	print("%s is now idle" % _amount_edit.name)

	_amount_edit.theme_type_variation = "IdleAmountEditContainer"

	_appearance.set_amount(0)

func enable() -> void:
	transition_state(AmountEdit.State.HIGHLIGHTED)
