@tool
class_name FileMenu extends PanelContainer

@export
var selected_index: int = 0:
	set(value):
		selected_index = clampi(value, 0, options.size() - 1)

		update_selection()

@export
var options: Array[FileMenuOption] = []:
	set(value):
		options = value

		update_selection()

@onready
var option_label: Label = %OptionLabel

var _active := false

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		return

	if Input.is_action_just_released("ui_right"):
		selected_index = (selected_index + 1) % options.size()
		return

	if Input.is_action_just_released("ui_left"):
		selected_index = (selected_index - 1 + options.size()) % options.size()
		return

func activate() -> void:
	_active = true

func deactivate() -> void:
	_active = false

func get_command() -> StringName:
	if not _active:
		return ""

	return options[selected_index].input

func update_selection() -> void:
	for i in len(options):
		if i == selected_index:
			if option_label:
				option_label.text = options[i].option_text

			options[i].self_modulate = Color.WHITE
		else:
			options[i].self_modulate = Color.DIM_GRAY
