class_name TransactionSelectPanelStateHighlighted
extends TransactionSelectPanelState

func _enter_tree() -> void:
	print("%s is now highlighted" % _transaction_select_panel.name)

	_transaction_select_panel.theme_type_variation = "HighlightedPanelContainer"

func unhighlight() -> void:
	transition_state(TransactionSelectPanel.State.IDLE)
