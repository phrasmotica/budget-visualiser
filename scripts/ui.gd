@tool
extends PanelContainer

signal created_save_data(data: SaveData)

var _save_data: SaveData

func _ready():
	_save_data = SaveData.new()

	_save_data.total_budget = 10000

	var t := Transaction.new()
	t.id = RandomNumberGenerator.new().randi()
	t.name = "Test transaction"
	t.amount = 100

	_save_data.transactions = [t]

func _on_app_app_quit() -> void:
	created_save_data.emit(_save_data)

func _on_saver_loader_loaded_data(data: SaveData) -> void:
	_save_data = data

	# TODO: update the UI with this data

func _on_budget_panel_budget_changed(budget: Budget) -> void:
	if Engine.is_editor_hint():
		return

	var data := SaveData.new()

	data.id = budget.id
	data.name = budget.name
	data.total_budget = budget.total_budget
	data.transactions = budget.transactions

	created_save_data.emit(data)
