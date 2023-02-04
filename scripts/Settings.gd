extends Control

onready var languages: OptionButton = $MarginContainer/VBoxContainer/Languages

func _ready() -> void:
	languages.add_item("English")
	languages.add_item("Italiano")
	TranslationServer.set_locale(Data.locale)
	if Data.locale == "en":
		languages.selected = 0
	elif Data.locale == "it":
		languages.selected = 1
	

func _on_Languages_item_selected(index: int) -> void:
	if index == 0:
		TranslationServer.set_locale("en")
		Data.locale = "en"
		print("0")
	if index == 1:
		TranslationServer.set_locale("it")
		Data.locale = "it"
		print("1")
