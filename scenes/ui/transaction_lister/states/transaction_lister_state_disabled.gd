class_name TransactionListerStateDisabled
extends TransactionListerState

func _enter_tree() -> void:
	Logger.debug("%s is now disabled" % _transaction_lister.name)

func enable() -> void:
	transition_state(TransactionLister.State.ENABLED)
