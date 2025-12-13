class_name TransactionListerStateEnabled
extends TransactionListerState

func _enter_tree() -> void:
	print("%s is now enabled" % _transaction_lister.name)

	if _transaction_panel_manager.count() > 0:
		_transaction_panel_manager.highlight(_index_tracker.current())

	# TODO: use the space bar to toggle the selected one for inclusion/removal
	# of the selected panel's transaction...

	SignalHelper.persist(
		GridInput.move_down,
		_on_move_down
	)

	SignalHelper.persist(
		GridInput.move_up,
		_on_move_up
	)

func _on_move_down() -> void:
	_transaction_panel_manager.highlight(_index_tracker.next())

func _on_move_up() -> void:
	_transaction_panel_manager.highlight(_index_tracker.previous())
