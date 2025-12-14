@tool
class_name TransactionListerAppearance
extends Node

@export
var scroll_container: ScrollContainer

@export
var finished_button: ButtonPanel

func for_enabled() -> void:
	finished_button.unhighlight()

func for_finishing() -> void:
	finished_button.highlight()

func scroll_down_to_highlighted_panel(panel: TransactionSelectPanel) -> void:
	VScroll.scroll_down_to(scroll_container, panel)

func scroll_up_to_highlighted_panel(panel: TransactionSelectPanel) -> void:
	VScroll.scroll_up_to(scroll_container, panel)
