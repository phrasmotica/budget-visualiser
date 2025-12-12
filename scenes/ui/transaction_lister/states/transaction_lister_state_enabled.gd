class_name TransactionListerStateEnabled
extends TransactionListerState

func _enter_tree() -> void:
	print("%s is now enabled" % _transaction_lister.name)

	# TODO: allow navigating through the list of TransactionSelectPanels, and
	# use the space bar to toggle the selected one for inclusion/removal of its
	# transaction...
