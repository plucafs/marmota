extends Node

var directory: String = ""
var extract_audio: int
var audio_format_selector: int
var locale : String = "en" setget set_locale

func _ready() -> void:
	TranslationServer.set_locale(locale)

func set_locale(value):
	locale = value
	var main = get_tree().get_nodes_in_group("main")[0]
	main.get_node("TabContainer/DownloadSection").save_config()
