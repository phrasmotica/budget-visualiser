@tool
class_name YearGridAppearance
extends Node

const LABEL_MIN_WIDTH := 300.0
const LABEL_FONT_SIZE := 32

const GRID_SCENE := preload("res://scenes/ui/month_grid/month_grid.tscn")

@export
var month_grid_manager: MonthGridManager

@export
var headers_parent: HBoxContainer

@export
var grid_parent: HBoxContainer

@export
var h_scroll_container: ScrollContainer

@export
var v_scroll_container: ScrollContainer

# TODO: make the category labels scroll vertically with the MonthGrids...

func for_idle() -> void:
	h_scroll_container.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_AUTO

func refresh_headers(label_owner: Control, months: Array[BudgetMonth]) -> void:
	var month_count := months.size()
	var child_count := headers_parent.get_child_count()

	for i in month_count:
		var label: Label

		if i >= child_count:
			label = Label.new()
			label.name = "MonthNameLabel%d" % i

			label.add_theme_font_size_override("font_size", LABEL_FONT_SIZE)
			label.custom_minimum_size = LABEL_MIN_WIDTH * Vector2.RIGHT

			headers_parent.add_child(label)
			label.owner = label_owner
		else:
			label = headers_parent.get_child(i)

		var new_text := "<Month%d>" % i

		var month := months[i]
		if month:
			new_text = month.name

		label.text = new_text

	while headers_parent.get_child_count() > month_count:
		var child := headers_parent.get_child(month_count)
		headers_parent.remove_child(child)

func refresh_grids(grid_owner: Control, months: Array[BudgetMonth]) -> void:
	var month_count := months.size()
	var child_count := grid_parent.get_child_count()

	if month_grid_manager:
		month_grid_manager.month_grids.clear()

	for i in month_count:
		var grid: MonthGrid

		if i >= child_count:
			grid = GRID_SCENE.instantiate()
			grid.name = "MonthGrid%d" % i

			grid_parent.add_child(grid)
			grid.owner = grid_owner
		else:
			grid = grid_parent.get_child(i)

		if month_grid_manager:
			month_grid_manager.month_grids.append(grid)

	while grid_parent.get_child_count() > month_count:
		var child := grid_parent.get_child(month_count)
		grid_parent.remove_child(child)

func scroll_right_to_highlighted_grid(grid: MonthGrid) -> void:
	var left := int(grid.position.x)
	var right := left + int(grid.size.x)

	if _can_see_grid(left, right):
		return

	var year_grid_end := int(h_scroll_container.scroll_horizontal + h_scroll_container.size.x)
	var scroll_amount_end := right - year_grid_end

	h_scroll_container.scroll_horizontal += scroll_amount_end

func scroll_left_to_highlighted_grid(grid: MonthGrid) -> void:
	var left := int(grid.position.x)
	var right := left + int(grid.size.x)

	if _can_see_grid(left, right):
		return

	h_scroll_container.scroll_horizontal = left

func _can_see_grid(left: int, right: int) -> bool:
	return \
		h_scroll_container.scroll_horizontal <= left and \
		h_scroll_container.scroll_horizontal + h_scroll_container.size.x >= right
