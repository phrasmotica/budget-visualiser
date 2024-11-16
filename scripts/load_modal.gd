class_name LoadModal extends PanelContainer

@onready
var warning_message: Label = %NoExistingBudgetsWarning

@onready
var existing_budgets_container: ScrollContainer = %ExistingBudgetsContainer

@onready
var existing_budgets_list: VBoxContainer = %ExistingBudgetsList

signal load_requested(file_name: String)
signal modal_hidden

var _file_names_internal: Array[String] = []

func inject(file_names: Array[String]) -> void:
	_file_names_internal = file_names

	refresh()

func refresh():
	var num_files := _file_names_internal.size()

	warning_message.visible = num_files <= 0
	existing_budgets_container.visible = num_files > 0

	for n in existing_budgets_list.get_children():
		existing_budgets_list.remove_child(n)
		n.queue_free()

	for file_name in _file_names_internal:
		var label := Label.new()
		label.text = file_name

		existing_budgets_list.add_child(label)

func _on_modal_input_handler_cancelled() -> void:
	modal_hidden.emit()

func _on_modal_buttons_cancelled() -> void:
	modal_hidden.emit()
