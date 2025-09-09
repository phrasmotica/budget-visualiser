class_name AmountEditStateHighlighted
extends AmountEditState

func _enter_tree() -> void:
	print("%s is now highlighted" % _amount_edit.name)
