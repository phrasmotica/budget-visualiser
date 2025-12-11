class_name CategoryLabelFactory

const LABEL_MIN_HEIGHT := 60.0
const LABEL_FONT_SIZE := 32

static func create_label(index: int) -> Label:
	var label := Label.new()
	label.name = "CategoryLabel%d" % index

	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.custom_minimum_size = LABEL_MIN_HEIGHT * Vector2i.DOWN
	label.add_theme_font_size_override("font_size", LABEL_FONT_SIZE)

	return label
