@tool
extends PanelContainer

@onready
var budget_panel: BudgetPanel = %BudgetPanel

@onready
var ledger_panel: LedgerPanel = %LedgerPanel

signal requested_load
signal created_save_data(data: SaveData)

var _save_data: SaveData
var _app_ready := false

func _ready():
	if not Engine.is_editor_hint():
		var screen_size := DisplayServer.screen_get_size()
		var small_window_size := screen_size * 3 / 4

		# display at 16:9 regardless of screen's aspect ratio
		var small_window_height := small_window_size.x * 9.0 / 16
		small_window_size.y = int(small_window_height)

		var window := get_window()

		window.size = small_window_size
		window.move_to_center()

func _on_saver_loader_loaded_data(data: SaveData) -> void:
	_save_data = data

	var budget := Budget.new()
	budget.id = data.id
	budget.name = data.name
	budget.total_budget = data.total_budget
	budget.transactions = data.transactions

	budget_panel.inject(budget)
	ledger_panel.inject(budget.transactions)

func _on_budget_panel_budget_changed(budget: Budget) -> void:
	if Engine.is_editor_hint():
		return

	if not _app_ready:
		print("App is not ready, preventing creation of save data.")
		return

	_save_data = SaveData.new()

	_save_data.id = budget.id
	_save_data.name = budget.name
	_save_data.total_budget = budget.total_budget
	_save_data.transactions = budget.transactions

	created_save_data.emit(_save_data)

func _on_app_app_ready() -> void:
	print("App is ready.")
	_app_ready = true

func _on_app_app_quit() -> void:
	created_save_data.emit(_save_data)

func _on_load_button_pressed() -> void:
	requested_load.emit()

func _on_save_button_pressed() -> void:
	created_save_data.emit(_save_data)
