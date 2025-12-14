@tool
class_name TransactionListerAppearance
extends Node

@export
var scroll_container: ScrollContainer

@export
var finished_button: ButtonPanel

# TODO: create a generalised scrolling helper class, and reuse it in other places...

func for_enabled() -> void:
	finished_button.unhighlight()

func for_finishing() -> void:
	finished_button.highlight()

func scroll_down_to_highlighted_panel(panel: TransactionSelectPanel) -> void:
	var top := int(panel.position.y)
	var bottom := top + int(panel.size.y)

	if _can_see_panel(top, bottom):
		return

	var end := int(scroll_container.scroll_vertical + scroll_container.size.y)
	var scroll_amount_end := bottom - end

	var new_scroll := scroll_container.scroll_vertical + scroll_amount_end

	scroll_container.scroll_vertical = new_scroll

func scroll_up_to_highlighted_panel(panel: TransactionSelectPanel) -> void:
	var top := int(panel.position.y)
	var bottom := top + int(panel.size.y)

	if _can_see_panel(top, bottom):
		return

	var new_scroll := top

	scroll_container.scroll_vertical = new_scroll

func _can_see_panel(top: int, bottom: int) -> bool:
	return \
		scroll_container.scroll_vertical <= top and \
		scroll_container.scroll_vertical + scroll_container.size.y >= bottom
