class_name AmountEntryModalAppearance
extends Node

@export
var edit_major: AmountEdit

@export
var edit_minor: AmountEdit

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
