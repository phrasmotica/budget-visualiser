class_name TransactionListerStateDisabled
extends TransactionListerState

func _enter_tree() -> void:
	print("%s is now disabled" % _transaction_lister.name)
