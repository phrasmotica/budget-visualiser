@tool
class_name TransactionListerAppearance
extends Node

const PANEL_SCENE := preload("res://scenes/ui/transaction_select_panel/transaction_select_panel.tscn")

@export
var panel_manager: TransactionPanelManager

@export
var scroll_container: ScrollContainer

@export
var panel_parent: VBoxContainer

func refresh_panels(panel_owner: Control, transactions: Array[BudgetTransaction]) -> void:
	var transaction_count := transactions.size()
	var child_count := panel_parent.get_child_count()

	if panel_manager:
		panel_manager.select_panels.clear()

	for i in transaction_count:
		var panel: TransactionSelectPanel

		if i >= child_count:
			panel = PANEL_SCENE.instantiate()
			panel.name = "TransactionSelectPanel%d" % i

			panel_parent.add_child(panel)
			panel.owner = panel_owner
		else:
			panel = panel_parent.get_child(i)

		panel.transaction = transactions[i]

		if panel_manager:
			panel_manager.select_panels.append(panel)

	while panel_parent.get_child_count() > transaction_count:
		var child := panel_parent.get_child(transaction_count)
		panel_parent.remove_child(child)

func for_enabled() -> void:
	pass

func for_finishing() -> void:
	pass

func scroll_down_to_highlighted_panel(panel: TransactionSelectPanel) -> void:
	VScroll.scroll_down_to(scroll_container, panel)

func scroll_up_to_highlighted_panel(panel: TransactionSelectPanel) -> void:
	VScroll.scroll_up_to(scroll_container, panel)
