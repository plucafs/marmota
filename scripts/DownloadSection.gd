extends Control

onready var format_selector = get_node("DownloadSection/OtherPar/FormatSelector")

func _ready():
	format_selector.add_item("Video + audio")
	format_selector.add_item("Audio only")

func download_video():
	var yt_dl_path = Global.yt_dl_dir
	var link = " " + $DownloadSection/VideoLinkContainer/VideoLinkLineEdit.get_text()
#		Don't insert a space (" ") before the -P
	var download_directory = "-P " + $DownloadSection/DownloadPathContainer/DownloadPathLineEdit.get_text()
	var format = ""
	
	if format_selector.selected == 0:
		format = ""
	if format_selector.selected == 1:
#		Don't insert a space (" ") before the -x
		format = "-x" 
		
	$DownloadSection/OtherPar/CompleteCommand.text = str(yt_dl_path) + format + download_directory + link
	
	if $DownloadSection/ytdlpPath/ytdlpPathLineEdit.text == "":
		$DownloadSection/OtherPar/Debug.text = "Select the correct path to yt-dlp.exe"
	else:
		if $DownloadSection/VideoLinkContainer/VideoLinkLineEdit.text == "":
			$DownloadSection/OtherPar/Debug.text = "Please, add one URL!"
		else:
			OS.execute(yt_dl_path, [format, download_directory, link])

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

		
