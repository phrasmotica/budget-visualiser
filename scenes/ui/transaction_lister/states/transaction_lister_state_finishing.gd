class_name TransactionListerStateFinishing
extends TransactionListerState

func _enter_tree() -> void:
	print("%s is now finishing" % _transaction_lister.name)

	_transaction_panel_manager.unhighlight()

	_appearance.for_finishing()

	SignalHelper.persist(
		GridInput.move_up,
		_on_move_up
	)

	SignalHelper.persist(
		_finished_button.pressed,
		_on_finished
	)

func _on_move_up() -> void:
	transition_state(TransactionLister.State.ENABLED)

func _on_finished() -> void:
	print("Finished toggling transactions")

func disable() -> void:
	transition_state(TransactionLister.State.DISABLED)
