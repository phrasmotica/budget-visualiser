class_name SectionSummariser

var _section: BudgetSection = null

func _init(
	section: BudgetSection,
) -> void:
	_section = section

func compute_total(month: BudgetMonth) -> float:
	return _compute_section_expenditure(_section, month)

func _compute_section_expenditure(
	section: BudgetSection,
	month: BudgetMonth,
) -> float:
	var budget_data := BudgetProvider.get_budget_data()

	var transactions := budget_data.all_transactions \
		.filter(func(t: BudgetTransaction): return section.categories.has(t.category)) \
		.filter(func(t: BudgetTransaction): return t.month == month)

	return _add_amounts(transactions)

func _add_amounts(transactions: Array[BudgetTransaction]) -> float:
	return transactions \
		.filter(func(t: BudgetTransaction): return not t.hidden) \
		.map(func(t: BudgetTransaction): return t.amount) \
		.reduce(Math.sum, 0.0)
