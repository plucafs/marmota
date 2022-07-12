extends Control

onready var format_selector = get_node("DownloadSection/OtherPar/FormatSelector")
onready var audio_format_selector = get_node("DownloadSection/OtherPar/AudioFormatSelector")

func _process(_delta):
	if "youtu" in OS.clipboard:
		$DownloadSection/VideoLinkContainer/VideoLinkLineEdit.text = OS.clipboard

func _ready():
	format_selector.add_item("Video + audio")
	format_selector.add_item("Audio only")
	audio_format_selector.add_item("aac")
	audio_format_selector.add_item("flac")
	audio_format_selector.add_item("mp3")
	audio_format_selector.add_item("m4a")
	audio_format_selector.add_item("opus")
	audio_format_selector.add_item("vorbis")
	audio_format_selector.add_item("wav")
	audio_format_selector.add_item("alac")
	
func download_video():
	var yt_dl_path = Global.yt_dl_dir + " "
	var format = ""
	var audio_format = ""
	var download_directory = "-P " + $DownloadSection/DownloadPathContainer/DownloadPathLineEdit.get_text() + " "
	var link = $DownloadSection/VideoLinkContainer/VideoLinkLineEdit.get_text()
	
	if format_selector.selected == 0:
		format = ""
	elif format_selector.selected == 1:
		format = "-x " 
		if audio_format_selector.selected == 0:
			audio_format = "--audio-format aac "
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
	
	$DownloadSection/OtherPar/CompleteCommand.text = yt_dl_path + format + audio_format + download_directory + link
	
	if $DownloadSection/ytdlpPath/ytdlpPathLineEdit.text == "":
		$DownloadSection/OtherPar/Debug.text = "Select the correct path to yt-dlp.exe"
	else:
		if $DownloadSection/VideoLinkContainer/VideoLinkLineEdit.text == "":
			$DownloadSection/OtherPar/Debug.text = "Please, add one URL!"
		else:
			OS.execute(yt_dl_path, [format, download_directory, link])
			OS.shell_open($DownloadSection/DownloadPathContainer/DownloadPathLineEdit.get_text())

func _on_VideoLinkButton_pressed():
	$DownloadSection/VideoLinkContainer/VideoLinkLineEdit.text = OS.clipboard

func _on_DownloadPathButton_pressed():
	$DownloadDialogSelectFolder.show()
	
func _on_ytdlpPathButton_pressed():
	$ytdlpDialogOpenFile.show()

func _on_StartDownload_pressed():
	download_video()

func _on_DownloadDialogSelectFolder_folder_selected(folder):
	$DownloadSection/DownloadPathContainer/DownloadPathLineEdit.text = folder

func _on_ytdlpDialogOpenFile_files_selected(files):
	var path = files[0]
	$DownloadSection/ytdlpPath/ytdlpPathLineEdit.text = path
	Global.yt_dl_dir = path

		
