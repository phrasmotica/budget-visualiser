@tool
class_name YearGridAppearance
extends Node

@export
var h_scroll_container: ScrollContainer

@export
var v_scroll_container: ScrollContainer

@export
var category_scroll_container: ScrollContainer

func for_idle() -> void:
	h_scroll_container.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_AUTO

func scroll_down_to_highlighted_cell(cell: CategoryCell) -> void:
	var top := int(cell.position.y)
	var bottom := top + int(cell.size.y)

	if _can_see_cell(top, bottom):
		return

	var year_grid_end := int(v_scroll_container.scroll_vertical + v_scroll_container.size.y)
	var scroll_amount_end := bottom - year_grid_end

	var new_scroll := v_scroll_container.scroll_vertical + scroll_amount_end

	v_scroll_container.scroll_vertical = new_scroll
	category_scroll_container.scroll_vertical = new_scroll

func scroll_up_to_highlighted_cell(cell: CategoryCell) -> void:
	var top := int(cell.position.y)
	var bottom := top + int(cell.size.y)

	if _can_see_cell(top, bottom):
		return

	var new_scroll := top

	v_scroll_container.scroll_vertical = new_scroll
	category_scroll_container.scroll_vertical = new_scroll

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

func _can_see_cell(top: int, bottom: int) -> bool:
	return \
		v_scroll_container.scroll_vertical <= top and \
		v_scroll_container.scroll_vertical + v_scroll_container.size.y >= bottom

func _can_see_grid(left: int, right: int) -> bool:
	return \
		h_scroll_container.scroll_horizontal <= left and \
		h_scroll_container.scroll_horizontal + h_scroll_container.size.x >= right
