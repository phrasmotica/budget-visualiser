class_name TransactionListerStateEnabled
extends TransactionListerState

func _enter_tree() -> void:
	print("%s is now enabled" % _transaction_lister.name)

	if _transaction_panel_manager.count() > 0:
		_transaction_panel_manager.highlight(_index_tracker.current())

	_finished_button.unhighlight()

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
	else:
		_transaction_panel_manager.highlight(_index_tracker.next())

func _on_move_bottom() -> void:
	_transaction_panel_manager.highlight(_index_tracker.last())

func _on_move_up() -> void:
	_transaction_panel_manager.highlight(_index_tracker.previous())

func _on_move_top() -> void:
	_transaction_panel_manager.highlight(_index_tracker.first())

func _process(_delta: float) -> void:
	if Input.is_action_just_released("ui_accept"):
		_transaction_panel_manager.toggle_current()
