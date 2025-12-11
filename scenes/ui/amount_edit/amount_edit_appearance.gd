@tool
class_name AmountEditAppearance
extends Node

@export
var symbol_label: Label

@export
var amount_label: Label

@export
var highlight_panel: PanelContainer

func for_idle() -> void:
	if highlight_panel:
		highlight_panel.theme_type_variation = "IdleAmountEditContainer"

func for_highlighted() -> void:
	if highlight_panel:
		highlight_panel.theme_type_variation = "HighlightedAmountEditContainer"

func set_currency_symbol(currency_symbol: String) -> void:
	if symbol_label:
		symbol_label.text = currency_symbol.substr(0, 1)

func set_amount(amount: int, pad_count: int) -> void:
	if amount_label:
		amount_label.text = str(amount).pad_zeros(pad_count)
