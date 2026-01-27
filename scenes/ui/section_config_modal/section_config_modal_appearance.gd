@tool
class_name SectionConfigModalAppearance
extends Node

@export
var header_label: Label

@export
var category_labels: CategoryLabels

func set_section(section: BudgetSection) -> void:
	if header_label:
		header_label.text = section.name if section else "<unknown>"

	if category_labels:
		category_labels.section = section
