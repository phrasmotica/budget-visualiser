class_name AmountEditStateHighlighted
extends AmountEditState

var _is_bulk := false

func _enter_tree() -> void:
	Logger.debug("%s is now highlighted" % _amount_edit.name)

	_appearance.for_highlighted()

	SignalHelper.persist(
		GridInput.move_up,
		_on_move_up
	)

	SignalHelper.persist(
		GridInput.move_down,
		_on_move_down
	)

	SignalHelper.persist(
		ModifierInput.bulk_modifier_pressed,
		_on_bulk_modifier_pressed
	)

	SignalHelper.persist(
		ModifierInput.bulk_modifier_released,
		_on_bulk_modifier_released
	)

func _on_bulk_modifier_pressed() -> void:
	_is_bulk = true

func _on_bulk_modifier_released() -> void:
	_is_bulk = false

func _on_move_up() -> void:
	var new_amount := _amount_tracker.add(_get_change_amount())
	var pad_count := len(str(_amount_tracker.get_maximum()))

	_appearance.set_amount(new_amount, pad_count)

	_emit_amount_changed(new_amount)

func _on_move_down() -> void:
	var new_amount := _amount_tracker.subtract(_get_change_amount())
	var pad_count := len(str(_amount_tracker.get_maximum()))

	_appearance.set_amount(new_amount, pad_count)

	_emit_amount_changed(new_amount)

func _get_change_amount() -> int:
	return 10 if _is_bulk else 1

func disable() -> void:
	transition_state(AmountEdit.State.IDLE)

func is_enabled() -> bool:
	return true
