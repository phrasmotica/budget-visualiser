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
var edit_major: AmountEdit

@export
var edit_minor: AmountEdit

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
	if edit_major:
		edit_major.enable()

	if edit_minor:
		edit_minor.disable()

func switch_amount_edits() -> void:
	if edit_major.is_enabled():
		edit_major.disable()
		edit_minor.enable()

	elif edit_minor.is_enabled():
		edit_major.enable()
		edit_minor.disable()
