class_name AmountEditStateHighlighted
extends AmountEditState

var _amount := 0
var _is_bulk := false

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

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("bulk_modifier"):
		_is_bulk = true

	if Input.is_action_just_released("bulk_modifier"):
		_is_bulk = false

func _on_move_up() -> void:
	_amount = mini(99, _amount + _get_change_amount())

	_appearance.set_amount(_amount)

func _on_move_down() -> void:
	_amount = maxi(0, _amount - _get_change_amount())

	_appearance.set_amount(_amount)

func _get_change_amount() -> int:
	return 10 if _is_bulk else 1

func disable() -> void:
	transition_state(AmountEdit.State.IDLE)

func is_enabled() -> bool:
	return true
