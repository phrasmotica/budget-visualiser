class_name YearGridStateIdle
extends YearGridState

func _enter_tree() -> void:
	print("%s is now idle" % _year_grid.name)

	_year_grid.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_AUTO

	if _month_grid_manager.count() > 0:
		_month_grid_manager.highlight(_index_tracker.current())

	_amount_entry_modal.disable()

	SignalHelper.once_next_frame(_inject_entered_amount)

	SignalHelper.persist(
		GridInput.move_right,
		_on_move_right
	)

	SignalHelper.persist(
		GridInput.move_left,
		_on_move_left
	)

func _inject_entered_amount() -> void:
	var entered_amount := _state_data.get_entered_amount()
	_month_grid_manager.inject_amount(entered_amount)

func _process(_delta: float) -> void:
	if Input.is_action_just_released("ui_accept"):
		_show_modal()

func _on_move_right() -> void:
	_month_grid_manager.highlight(_index_tracker.next())

func _on_move_left() -> void:
	_month_grid_manager.highlight(_index_tracker.previous())

func _show_modal() -> void:
	_amount_entry_modal.enable(0.0)

	transition_state(YearGrid.State.DISABLED)
