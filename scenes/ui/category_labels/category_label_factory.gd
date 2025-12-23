class_name CategoryLabelFactory

const LABEL_MIN_HEIGHT := 60.0

static func create_label(index: int) -> Label:
	var label := Label.new()
	label.name = "CategoryLabel%d" % index

	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.custom_minimum_size = LABEL_MIN_HEIGHT * Vector2i.DOWN

	return label
