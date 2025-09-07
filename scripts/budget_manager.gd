extends Node

signal created_new_budget(budget: Budget)

func _on_new_button_pressed() -> void:
	create_new()

func _on_file_menu_handler_new_budget() -> void:
	create_new()

func create_new() -> void:
	var b := Budget.new()
	b.id = randi()
	b.name = "New budget"

	created_new_budget.emit(b)
