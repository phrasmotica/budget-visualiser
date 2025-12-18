class_name AmountEntryModalStateHidden
extends AmountEntryModalState

func _enter_tree() -> void:
	Logger.debug("%s is now hidden" % _amount_entry_modal.name)

	_amount_entry_modal.hide()

func enable(
	category: BudgetCategory,
	month: BudgetMonth,
	amount: float,
	starting_amount: float,
) -> void:
	var state_data := AmountEntryModalStateData.build() \
		.with_category(category) \
		.with_month(month) \
		.with_amount(amount) \
		.with_starting_amount(starting_amount)

	transition_state(AmountEntryModal.State.SHOWN, state_data)
