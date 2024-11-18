extends PanelContainer

@onready
var name_edit: LineEdit = %NameEdit

@onready
var modal_buttons: ModalButtons = %ModalButtons

var _text_internal := ""

signal name_submitted(new_name: String)
signal modal_hidden

func submit(new_name: String):
	if len(new_name) <= 0:
		return

	print("Submitting budget name " + new_name)

	name_submitted.emit(new_name)

func refresh():
	if modal_buttons:
		modal_buttons.confirm_disabled = _text_internal.length() <= 0

func inject(budget: Budget) -> void:
	inject_name(budget.name)

func inject_name(budget_name: String) -> void:
	if name_edit:
		name_edit.text = budget_name

func _on_modal_input_handler_cancelled() -> void:
	modal_hidden.emit()

func _on_name_edit_text_changed(new_text: String) -> void:
	_text_internal = new_text

	refresh()

func _on_name_edit_text_submitted(new_text: String) -> void:
	submit(new_text)

func _on_modal_buttons_cancelled() -> void:
	modal_hidden.emit()

func _on_modal_buttons_confirmed() -> void:
	submit(name_edit.text)

func _on_visibility_changed() -> void:
	if visible:
		if name_edit:
			name_edit.grab_focus()
			name_edit.select_all()
