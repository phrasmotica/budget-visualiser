class_name LoadModal extends PanelContainer

@onready
var warning_message: Label = %NoExistingBudgetsWarning

@onready
var existing_budgets_container: ScrollContainer = %ExistingBudgetsContainer

@onready
var existing_budgets_list: VBoxContainer = %ExistingBudgetsList

@onready
var budget_list_item_scene: PackedScene = preload("res://scenes/budget_list_item.tscn")

signal load_requested(file_name: String)
signal modal_hidden

var _file_names_internal: Array[String] = []
var _list_items: Array[Button] = []
var _selected_idx := -1

func _ready() -> void:
	refresh()

func inject(file_names: Array[String]) -> void:
	_file_names_internal = file_names

	refresh()

func refresh() -> void:
	var num_files := _file_names_internal.size()

	warning_message.visible = num_files <= 0
	existing_budgets_container.visible = num_files > 0

	refresh_file_names()
	refresh_list_items()

func refresh_file_names() -> void:
	_list_items.clear()

	for n in existing_budgets_list.get_children():
		existing_budgets_list.remove_child(n)
		n.queue_free()

	_file_names_internal.sort_custom(
		func(s: String, t: String):
			return FileAccess.get_modified_time("user://" + s) > FileAccess.get_modified_time("user://" + t)
	)

	for i in _file_names_internal.size():
		var file_name := _file_names_internal[i]
		var data: SaveData = ResourceLoader.load("user://" + file_name)

		var list_item: Button = budget_list_item_scene.instantiate()
		list_item.text = data.name

		list_item.pressed.connect(
			func():
				handle_list_item_pressed(i)
		)

		_list_items.append(list_item)
		existing_budgets_list.add_child(list_item)

func refresh_list_items():
	for i in _list_items.size():
		var li := _list_items[i]
		li.button_pressed = i == _selected_idx

func handle_list_item_pressed(idx: int) -> void:
	_selected_idx = idx

	refresh_list_items()

func _on_modal_input_handler_cancelled() -> void:
	modal_hidden.emit()

func _on_modal_buttons_cancelled() -> void:
	modal_hidden.emit()
