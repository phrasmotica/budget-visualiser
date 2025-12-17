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
	h_scroll_container.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_SHOW_NEVER

func scroll_down_to_highlighted_cell(cell: CategoryCell) -> void:
	var new_scroll := VScroll.scroll_down_to(v_scroll_container, cell)

	category_scroll_container.scroll_vertical = new_scroll

func scroll_up_to_highlighted_cell(cell: CategoryCell) -> void:
	var new_scroll := VScroll.scroll_up_to(v_scroll_container, cell)

	category_scroll_container.scroll_vertical = new_scroll

func scroll_right_to_highlighted_grid(grid: MonthGrid) -> void:
	HScroll.scroll_right_to(h_scroll_container, grid)

func scroll_left_to_highlighted_grid(grid: MonthGrid) -> void:
	HScroll.scroll_left_to(h_scroll_container, grid)
