@tool
extends PanelContainer

@onready
var budget_panel: BudgetPanel = %BudgetPanel

signal requested_load
signal created_save_data(data: SaveData)

var _save_data: SaveData

func _on_app_app_quit() -> void:
	created_save_data.emit(_save_data)

func _on_saver_loader_loaded_data(data: SaveData) -> void:
	_save_data = data

	var budget := Budget.new()
	budget.id = data.id
	budget.name = data.name
	budget.total_budget = data.total_budget
	budget.transactions = data.transactions

	budget_panel.inject(budget)

func _on_budget_panel_budget_changed(budget: Budget) -> void:
	if Engine.is_editor_hint():
		return

	var data := SaveData.new()

	data.id = budget.id
	data.name = budget.name
	data.total_budget = budget.total_budget
	data.transactions = budget.transactions

	created_save_data.emit(data)

func _on_load_button_pressed() -> void:
	requested_load.emit()

func _on_save_button_pressed() -> void:
	created_save_data.emit(_save_data)
