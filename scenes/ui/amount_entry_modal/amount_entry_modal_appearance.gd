@tool
class_name AmountEntryModalAppearance
extends Node

@export
var header_label: Label

@export
var sub_header_label: Label

@export
var caption_label: Label

@export
var spinner: AmountSpinner

func set_title(title: String) -> void:
	if header_label:
		header_label.text = title

func set_sub_header(sub_header: String) -> void:
	if sub_header_label:
		sub_header_label.text = sub_header

func set_caption(caption: String) -> void:
	if caption_label:
		caption_label.text = caption

func for_shown() -> void:
	if spinner:
		spinner.reset_appearance()

func switch_amount_edits() -> void:
	if spinner:
		spinner.switch_amount_edits()
