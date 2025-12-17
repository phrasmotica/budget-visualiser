class_name TransactionSelectPanelStateIdle
extends TransactionSelectPanelState

func _enter_tree() -> void:
	print("%s is now idle" % _transaction_select_panel.name)

	_transaction_select_panel.theme_type_variation = "IdlePanelContainer"

func highlight() -> void:
	transition_state(TransactionSelectPanel.State.HIGHLIGHTED)
