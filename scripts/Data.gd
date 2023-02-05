extends Node

var directory: String = ""
var extract_audio: int
var audio_format_selector: int
var locale : String = "en" setget set_locale
var open_folder_after_download : bool = true setget set_open_folder_after_download


func _ready() -> void:
	TranslationServer.set_locale(locale)

func set_locale(value):
	locale = value
	var main = get_tree().get_nodes_in_group("main")[0].get_node("TabContainer/DownloadSection")
	main.save_config()

func set_open_folder_after_download(value):
	open_folder_after_download = value
	var main = get_tree().get_nodes_in_group("main")[0].get_node("TabContainer/DownloadSection")
	main.save_config()
