class_name AmountEditStateHighlighted
extends AmountEditState

var _amount := 0

func _enter_tree() -> void:
	print("%s is now highlighted" % _amount_edit.name)

	_amount_edit.theme_type_variation = "HighlightedAmountEditContainer"

	SignalHelper.persist(
		GridInput.move_up,
		_on_move_up
	)

	SignalHelper.persist(
		GridInput.move_down,
		_on_move_down
	)

func _on_move_up() -> void:
	_amount = mini(99, _amount + 1)

	_appearance.set_amount(_amount)

func _on_move_down() -> void:
	_amount = maxi(0, _amount - 1)

	_appearance.set_amount(_amount)

func disable() -> void:
	transition_state(AmountEdit.State.IDLE)
