class_name HScroll

static func scroll_right_to(
	scroll_container: ScrollContainer,
	child: Control,
) -> int:
	var left := int(child.position.x)
	var right := left + int(child.size.x)

	if _can_see_grid(scroll_container, left, right):
		return scroll_container.scroll_horizontal

	var end := int(scroll_container.scroll_horizontal + scroll_container.size.x)
	var scroll_amount_end := right - end

	scroll_container.scroll_horizontal += scroll_amount_end

	return scroll_container.scroll_horizontal

static func scroll_left_to(
	scroll_container: ScrollContainer,
	child: Control,
) -> int:
	var left := int(child.position.x)
	var right := left + int(child.size.x)

	if _can_see_grid(scroll_container, left, right):
		return scroll_container.scroll_horizontal

	scroll_container.scroll_horizontal = left

	return scroll_container.scroll_horizontal

static func _can_see_grid(
	scroll_container: ScrollContainer,
	child_left: int,
	child_right: int,
) -> bool:
	return \
		scroll_container.scroll_horizontal <= child_left and \
		scroll_container.scroll_horizontal + scroll_container.size.x >= child_right
