@tool
class_name CheckBoxOrDeleteButton extends HBoxContainer

@export
var checked := false:
	set(value):
		checked = value

		update_checkbox()

@export
var delete_mode := false:
	set(value):
		delete_mode = value

		update_mode()

@export
var disabled_mode := false:
	set(value):
		disabled_mode = value

		update_mode()

@onready
var delete_button: TextureButton = %DeleteButton

@onready
var check_box: Button = %CheckBox

signal check_box_pressed(checked: bool)
signal delete_button_pressed

func update_checkbox():
	if check_box:
		check_box.button_pressed = checked

func update_mode():
	if delete_button:
		delete_button.visible = delete_mode

	if check_box:
		check_box.visible = not delete_mode
		check_box.disabled = disabled_mode

func _on_check_box_pressed() -> void:
	check_box_pressed.emit(check_box.button_pressed)

func _on_delete_button_pressed() -> void:
	delete_button_pressed.emit()
