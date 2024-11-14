class_name FileMenuHandler extends Node

@export
var file_menu: FileMenu

signal new_budget

func handle():
	var command := file_menu.get_command()
	if command.length() <= 0:
		return

	match command:
		"file_menu_new_budget":
			print("Creating a new budget from file menu")
			new_budget.emit()
		_:
			print("Cancelling file menu")

func _on_hold_to_show_handler_activated() -> void:
	file_menu.activate()

func _on_hold_to_show_handler_deactivated() -> void:
	handle()
	file_menu.deactivate()
