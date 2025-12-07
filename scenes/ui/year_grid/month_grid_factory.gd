class_name MonthGridFactory

const LABEL_MIN_WIDTH := 300.0
const LABEL_FONT_SIZE := 32

const GRID_SCENE := preload("res://scenes/ui/month_grid/month_grid.tscn")

static func create_label(index: int) -> Label:
	var label := Label.new()

	label.name = "MonthNameLabel%d" % index

	label.add_theme_font_size_override("font_size", LABEL_FONT_SIZE)
	label.custom_minimum_size = LABEL_MIN_WIDTH * Vector2.RIGHT

	return label

static func create_grid(index: int) -> MonthGrid:
	var grid := GRID_SCENE.instantiate()

	grid.name = "MonthGrid%d" % index

	return grid
