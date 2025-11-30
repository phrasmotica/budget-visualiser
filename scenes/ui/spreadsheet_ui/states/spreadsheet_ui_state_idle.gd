class_name SpreadsheetUIStateIdle
extends SpreadsheetUIState

func _enter_tree() -> void:
	print("%s is now idle" % _spreadsheet_ui.name)
