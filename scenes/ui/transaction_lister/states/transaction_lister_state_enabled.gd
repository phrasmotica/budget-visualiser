class_name TransactionListerStateEnabled
extends TransactionListerState

func _enter_tree() -> void:
	print("%s is now enabled" % _transaction_lister.name)

	if _transaction_panel_manager.count() > 0:
		_transaction_panel_manager.highlight(_index_tracker.current())

	_appearance.for_enabled()

	SignalHelper.persist(
		GridInput.move_down,
		_on_move_down
	)

	SignalHelper.persist(
		GridInput.move_bottom,
		_on_move_bottom
	)

	SignalHelper.persist(
		GridInput.move_up,
		_on_move_up
	)

	SignalHelper.persist(
		GridInput.move_top,
		_on_move_top
	)

func _on_move_down() -> void:
	if _index_tracker.is_last():
		transition_state(TransactionLister.State.FINISHING)
		return

	var new_panel := _transaction_panel_manager.highlight(_index_tracker.next())
	_appearance.scroll_down_to_highlighted_panel(new_panel)

func _on_move_bottom() -> void:
	var new_panel := _transaction_panel_manager.highlight(_index_tracker.last())
	_appearance.scroll_down_to_highlighted_panel(new_panel)

func _on_move_up() -> void:
	var new_panel := _transaction_panel_manager.highlight(_index_tracker.previous())
	_appearance.scroll_up_to_highlighted_panel(new_panel)

func _on_move_top() -> void:
	var new_panel := _transaction_panel_manager.highlight(_index_tracker.first())
	_appearance.scroll_up_to_highlighted_panel(new_panel)

func _process(_delta: float) -> void:
	if Input.is_action_just_released("ui_accept"):
		_transaction_panel_manager.toggle_current()
