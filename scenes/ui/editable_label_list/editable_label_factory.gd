class_name EditableLabelFactory

const EDITABLE_LABEL_SCENE := preload("res://scenes/ui/editable_label/editable_label.tscn")

static func create_label(index: int) -> EditableLabel:
	var label: EditableLabel = EDITABLE_LABEL_SCENE.instantiate()
	label.name = "EditableLabel%d" % index

	return label
