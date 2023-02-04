extends Control

#To do: 
#history of links/directories
#add more yt-dlp commands

#Process to save configs:
#Create value in the Data singleton
#Add value to save_config()
#Add value to load_config()
#Set the value when an event occurs
#Load the value at startup

onready var format_selector = get_node("%FormatSelector")
onready var audio_format_selector = get_node("%AudioFormatSelector")
onready var url = get_node("%LinkText")
onready var directory = get_node("%DirectoryText")
onready var debug = get_node("%Debug")

var format = ""
var audio_format = ""

func _ready():
#	name = "KEY_DOWNLOAD_SECTION"
	if load_config():
		save_config()
		
#	url.text = "https://www.youtube.com/watch?v=1s84rIhPuhk"
#	directory.text = "/home/user/Video/"
	
	format_selector.add_item("Video + audio")
	format_selector.add_item("KEY_AUDIO")
	audio_format_selector.add_item("aac")
	audio_format_selector.add_item("flac")
	audio_format_selector.add_item("mp3")
	audio_format_selector.add_item("m4a")
	audio_format_selector.add_item("opus")
	audio_format_selector.add_item("vorbis")
	audio_format_selector.add_item("wav")
	audio_format_selector.add_item("alac")
	
	format_selector.selected = Data.extract_audio
	audio_format_selector.selected = Data.audio_format_selector

func _process(_delta):
	if "youtu" in OS.clipboard:
		url.text = OS.clipboard

func save_config():
	var config = ConfigFile.new()
	# Section, key, value
	config.set_value("settings", "directory", Data.directory)
	config.set_value("settings", "extract_audio", Data.extract_audio)
	config.set_value("settings", "audio_format_selector", Data.audio_format_selector)
	config.set_value("settings", "locale", Data.locale)
	config.save("user://config.cfg")

func load_config():
	var config = ConfigFile.new()
	var err = config.load("user://config.cfg")
	if err != OK:
		return true
	for section in config.get_sections():
		directory.text = config.get_value(section, "directory")
		Data.extract_audio = config.get_value(section, "extract_audio")
		Data.audio_format_selector = config.get_value(section, "audio_format_selector")
		Data.locale = config.get_value(section, "locale")
		
func download_video():
	if format_selector.selected == 0:
		format = ""
	elif format_selector.selected == 1:
		format = "--extract-audio" 
		if audio_format_selector.selected == 0:
			audio_format = "--audio-format aac"
		elif audio_format_selector.selected == 1:
			audio_format = "--audio-format flac"
		elif audio_format_selector.selected == 2:
			audio_format = "--audio-format mp3"
		elif audio_format_selector.selected == 3:
			audio_format = "--audio-format m4a"
		elif audio_format_selector.selected == 4:
			audio_format = "--audio-format opus"
		elif audio_format_selector.selected == 5:
			audio_format = "--audio-format vorbis"
		elif audio_format_selector.selected == 6:
			audio_format = "--audio-format wav"
		elif audio_format_selector.selected == 7:
			audio_format = "--audio-format alac"
	
	if url.text == "":
		debug.text = "Paste a link to continue"
		return
		
	if directory.text == "":
		debug.text = "Paste a directory to continue"
	
	else:
		var arguments = ["--paths", '"' + directory.text + '"', '"' + url.text + '"']
		if audio_format:
			arguments.append('"' + format + '"')
			if audio_format_selector:
				arguments.append('"' + audio_format + '"')
		debug.text = PoolStringArray(arguments).join(" ")
		OS.execute("yt-dlp", arguments, true)
		clear_field()
		OS.shell_open(directory.text)

func clear_field():
#	directory.clear()
	url.clear()

#func _on_LinkButton_pressed():
#	url.text = OS.clipboard

func _on_StartDownload_pressed():
	download_video()

func _on_DirectoryButton_pressed() -> void:
	get_node("Node/SelectFolder").show()

func _on_SelectFolder_folder_selected(folder: String) -> void:
	if !folder:
		return
	directory.text = folder
	Data.directory = folder
	save_config()

func _on_DirectoryText_text_changed(new_text: String) -> void:
	Data.directory = new_text
	save_config()

func _on_FormatSelector_item_selected(index: int) -> void:
	Data.extract_audio = index
	save_config()
	
func _on_AudioFormatSelector_item_selected(index: int) -> void:
	Data.audio_format_selector = index
	save_config()
