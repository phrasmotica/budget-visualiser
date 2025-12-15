class_name TransactionListerModalStateShown
extends TransactionListerModalState

func _enter_tree() -> void:
	print("%s is now shown" % _transaction_lister_modal.name)
