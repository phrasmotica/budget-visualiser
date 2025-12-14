class_name VScroll

static func scroll_down_to(
	scroll_container: ScrollContainer,
	child: Control,
) -> int:
	var top := int(child.position.y)
	var bottom := top + int(child.size.y)

	if _can_see_child(scroll_container, top, bottom):
		return scroll_container.scroll_vertical

	var end := int(scroll_container.scroll_vertical + scroll_container.size.y)
	var scroll_amount_end := bottom - end

	var new_scroll := scroll_container.scroll_vertical + scroll_amount_end

	scroll_container.scroll_vertical = new_scroll

	return new_scroll

static func scroll_up_to(
	scroll_container: ScrollContainer,
	child: Control,
) -> int:
	var top := int(child.position.y)
	var bottom := top + int(child.size.y)

	if _can_see_child(scroll_container, top, bottom):
		return scroll_container.scroll_vertical

	var new_scroll := top

	scroll_container.scroll_vertical = new_scroll

	return new_scroll

static func _can_see_child(
	scroll_container: ScrollContainer,
	child_top: int,
	child_bottom: int,
) -> bool:
	return \
		scroll_container.scroll_vertical <= child_top and \
		scroll_container.scroll_vertical + scroll_container.size.y >= child_bottom
