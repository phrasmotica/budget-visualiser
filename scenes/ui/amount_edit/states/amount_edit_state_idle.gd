class_name AmountEditStateIdle
extends AmountEditState

func _enter_tree() -> void:
	print("%s is now idle" % _amount_edit.name)
