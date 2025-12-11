extends Node

func load_or_create() -> void:
	var latest_budget := SaverLoader.load_latest_budget()

	if not latest_budget:
		latest_budget = create_new()

	BudgetProvider.set_budget_data(latest_budget)

func create_new() -> BudgetData:
	var budget_data := BudgetData.new()

	budget_data.id = randi()
	budget_data.name = "New budget"

	return budget_data
