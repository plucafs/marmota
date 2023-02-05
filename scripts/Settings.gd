extends Control

onready var languages: OptionButton = $MarginContainer/VBoxContainer/Languages
onready var open_folder: CheckBox = $MarginContainer/VBoxContainer/HBoxContainer/OpenFolder

func _ready() -> void:
	languages.add_item("English")
	languages.add_item("Italiano")
	TranslationServer.set_locale(Data.locale)
	if Data.locale == "en":
		languages.selected = 0
	elif Data.locale == "it":
		languages.selected = 1
	open_folder.pressed = Data.open_folder_after_download
		


func _on_Languages_item_selected(index: int) -> void:
	if index == 0:
		TranslationServer.set_locale("en")
		Data.locale = "en"
		print("0")
	if index == 1:
		TranslationServer.set_locale("it")
		Data.locale = "it"
		print("1")


func _on_OpenFolder_toggled(button_pressed: bool) -> void:
	Data.open_folder_after_download = button_pressed
