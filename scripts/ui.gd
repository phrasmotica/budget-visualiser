@tool
extends PanelContainer

@onready
var tab_container: TabContainer = %TabContainer

@onready
var rename_modal_container: Container = %RenameModalContainer

@onready
var load_modal_container: Container = %LoadModalContainer

@onready
var load_modal: LoadModal = %LoadModal

@onready
var rename_modal: Control = %RenameModal

@onready
var file_menu_container: Container = %FileMenuContainer

@onready
var file_menu_hold_to_show_handler: HoldToShowHandler = %FileMenuHoldToShowHandler

@onready
var budget_container_scene: PackedScene = preload("res://scenes/budget_container.tscn")

signal existing_data_requested
signal requested_load
signal created_save_data(data: SaveData, is_new: bool)
signal modal_shown
signal modal_hidden

var _save_data_map := {}
var _current_tab_id := -1
var _current_budget_id := -1
var _app_ready := false

func _ready():
	if not Engine.is_editor_hint():
		var screen_size := DisplayServer.screen_get_size()
		var small_window_size := screen_size * 3 / 4

		# display at 16:10 regardless of screen's aspect ratio
		var small_window_height := small_window_size.x * 5.0 / 8
		small_window_size.y = int(small_window_height)

		var window := get_window()

		window.size = small_window_size
		window.move_to_center()

		for c in tab_container.get_children():
			tab_container.remove_child(c)
			c.queue_free()

		if rename_modal_container:
			rename_modal_container.hide()

		if load_modal_container:
			load_modal_container.hide()

		if file_menu_container:
			file_menu_container.hide()

func set_budget_title(title: String):
	tab_container.set_tab_title(_current_tab_id, title)

func convert_to_save_data(budget: Budget) -> SaveData:
	var save_data := SaveData.new()

	save_data.id = budget.id
	save_data.name = budget.name
	save_data.total_budget = budget.total_budget
	save_data.transactions = budget.transactions
	save_data.bills = budget.bills

	return save_data

func get_save_data(id: int) -> SaveData:
	return _save_data_map[id] if _save_data_map.has(id) else null

func open_in_new_tab(budget: Budget) -> void:
	var new_container: BudgetContainer = budget_container_scene.instantiate()
	new_container.budget_changed.connect(handle_budget_changed)

	modal_shown.connect(new_container.prevent_input)
	modal_hidden.connect(new_container.allow_input)

	file_menu_hold_to_show_handler.activated.connect(new_container.prevent_input)
	file_menu_hold_to_show_handler.deactivated.connect(new_container.allow_input)

	tab_container.add_child(new_container)

	var idx := tab_container.get_child_count() - 1
	tab_container.current_tab = idx
	tab_container.set_tab_title(idx, budget.name)

	new_container.inject(budget)
	rename_modal.inject(budget)

	refresh_current_budget()

	if load_modal_container:
		load_modal_container.hide()

func _on_saver_loader_existing_data_read(file_names: Array[String]) -> void:
	load_modal.inject(file_names)

func _on_saver_loader_loaded_data(data: SaveData) -> void:
	_save_data_map[data.id] = data

	var budget := Budget.new()
	budget.id = data.id
	budget.name = data.name
	budget.total_budget = data.total_budget
	budget.transactions = data.transactions
	budget.bills = data.bills

	open_in_new_tab(budget)

func _on_budget_container_budget_changed(budget: Budget) -> void:
	handle_budget_changed(budget)

func handle_budget_changed(budget: Budget) -> void:
	if Engine.is_editor_hint():
		return

	if not _app_ready:
		print("App is not ready, preventing creation of save data.")
		return

	if not _save_data_map.has(budget.id):
		_save_data_map[budget.id] = SaveData.new()

	_save_data_map[budget.id].id = budget.id
	_save_data_map[budget.id].total_budget = budget.total_budget
	_save_data_map[budget.id].transactions = budget.transactions
	_save_data_map[budget.id].bills = budget.bills

	created_save_data.emit(get_save_data(budget.id), false)

func _on_app_app_ready() -> void:
	print("App is ready.")
	_app_ready = true

func _on_app_app_quit() -> void:
	var data := get_save_data(_current_budget_id)
	if data:
		created_save_data.emit(data, false)

func _on_load_button_pressed() -> void:
	if load_modal_container:
		load_modal_container.show()
		existing_data_requested.emit()

	modal_shown.emit()

func _on_save_button_pressed() -> void:
	var data := get_save_data(_current_budget_id)
	if data:
		created_save_data.emit(data, false)

func _on_edit_button_pressed() -> void:
	if rename_modal_container:
		rename_modal_container.show()

	modal_shown.emit()

func _on_rename_modal_name_submitted(new_name: String) -> void:
	if not _save_data_map.has(_current_budget_id):
		print("Can't rename non-existent budget ID=%d" % _current_budget_id)
		return

	print("Renaming budget to " + new_name)

	_save_data_map[_current_budget_id].name = new_name

	set_budget_title(new_name)

	created_save_data.emit(get_save_data(_current_budget_id), false)

	if rename_modal_container:
		rename_modal_container.hide()

	modal_hidden.emit()

func _on_rename_modal_modal_hidden() -> void:
	rename_modal_container.hide()

	modal_hidden.emit()

func _on_load_modal_load_requested(file_name: String) -> void:
	print("Loading budget from " + file_name)

	requested_load.emit(file_name)

func _on_load_modal_modal_hidden() -> void:
	load_modal_container.hide()

	modal_hidden.emit()

func _on_budget_manager_created_new_budget(budget: Budget) -> void:
	print("Created new budget ID=%d" % budget.id)

	var new_save_data := convert_to_save_data(budget)
	created_save_data.emit(new_save_data, true)

	_save_data_map[budget.id] = new_save_data

	open_in_new_tab(budget)

func _on_tab_container_tab_selected(tab: int) -> void:
	_current_tab_id = tab

	print("Selected tab %d" % tab)

func _on_tab_container_tab_changed(tab: int) -> void:
	_current_tab_id = tab

	print("Changed to tab %d" % tab)

	refresh_current_budget()

func refresh_current_budget() -> void:
	var selected_budget_container: BudgetContainer = tab_container.get_child(_current_tab_id)
	_current_budget_id = selected_budget_container.get_budget_id()

	if _current_budget_id >= 0:
		var save_data := get_save_data(_current_budget_id)
		rename_modal.inject_name(save_data.name)
	else:
		_current_budget_id = -1

	print("Current budget ID=%d" % _current_budget_id)
