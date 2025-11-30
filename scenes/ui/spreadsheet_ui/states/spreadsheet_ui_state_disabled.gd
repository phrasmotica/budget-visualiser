class_name SpreadsheetUIStateDisabled
extends SpreadsheetUIState

func _enter_tree() -> void:
	print("%s is now disabled" % _spreadsheet_ui.name)
