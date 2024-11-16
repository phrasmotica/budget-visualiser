@tool
class_name ModalButtons extends HBoxContainer

@export
var confirm_text := "Save":
	set(value):
		confirm_text = value

		refresh()

@export
var confirm_disabled := false:
	set(value):
		confirm_disabled = value

		refresh()

@onready
var confirm_button: Button = %ConfirmButton

signal cancelled
signal confirmed

func _ready():
	refresh()

func refresh():
	if confirm_button:
		confirm_button.text = confirm_text
		confirm_button.disabled = confirm_disabled

func _on_cancel_button_pressed() -> void:
	cancelled.emit()

func _on_confirm_button_pressed() -> void:
	confirmed.emit()
