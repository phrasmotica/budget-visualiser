extends PanelContainer

signal load_requested(file_name: String)
signal modal_hidden

func _on_modal_input_handler_cancelled() -> void:
	modal_hidden.emit()

func _on_modal_buttons_cancelled() -> void:
	modal_hidden.emit()
