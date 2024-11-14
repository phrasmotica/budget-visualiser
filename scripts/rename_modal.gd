extends PanelContainer

@onready
var name_edit: LineEdit = %NameEdit

@onready
var save_button: Button = %SaveButton

var _text_internal := ""

signal name_submitted(new_name: String)
signal modal_hidden

func _ready():
	refresh()

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		return

	handle_input()

func handle_input():
	if Input.is_action_just_pressed("ui_cancel"):
		modal_hidden.emit()

func submit(new_name: String):
	if len(new_name) <= 0:
		return

	print("Submitting budget name " + new_name)

	name_submitted.emit(new_name)

func refresh():
	if save_button:
		save_button.disabled = len(_text_internal) <= 0

func inject(budget: Budget):
	if name_edit:
		name_edit.text = budget.name

func _on_name_edit_text_changed(new_text: String) -> void:
	_text_internal = new_text

	refresh()

func _on_name_edit_text_submitted(new_text: String) -> void:
	submit(new_text)

func _on_cancel_button_pressed() -> void:
	modal_hidden.emit()

func _on_save_button_pressed() -> void:
	submit(name_edit.text)

func _on_visibility_changed() -> void:
	if visible:
		if name_edit:
			name_edit.grab_focus()
			name_edit.select_all()
