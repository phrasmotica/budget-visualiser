extends PanelContainer

@onready
var name_edit: LineEdit = %NameEdit

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		return

	handle_input()

func handle_input():
	if Input.is_action_just_pressed("ui_cancel"):
		close_modal()

func close_modal():
	hide()

func _on_cancel_button_pressed() -> void:
	close_modal()

func _on_save_button_pressed() -> void:
	# TODO: save the name of the budget
	pass

func _on_visibility_changed() -> void:
	if visible:
		if name_edit:
			name_edit.grab_focus()
			name_edit.select_all()
