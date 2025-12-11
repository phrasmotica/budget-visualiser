class_name AmountEditStateIdle
extends AmountEditState

func _enter_tree() -> void:
	print("%s is now idle" % _amount_edit.name)

	_appearance.for_idle()

func enable() -> void:
	transition_state(AmountEdit.State.HIGHLIGHTED)
