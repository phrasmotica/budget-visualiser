@tool
class_name DigitSpinnerAppearance
extends Node

@export
var highlight_panel: PanelContainer

@export
var amount_label: Label

func for_idle() -> void:
	if highlight_panel:
		highlight_panel.theme_type_variation = "IdleDigitSpinnerContainer"

func for_active() -> void:
	if highlight_panel:
		highlight_panel.theme_type_variation = "HighlightedDigitSpinnerContainer"

func set_amount(amount: int) -> void:
	if amount_label:
		amount_label.text = str(amount)
