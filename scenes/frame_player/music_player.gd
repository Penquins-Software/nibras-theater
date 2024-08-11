class_name MusicPlayer
extends AudioStreamPlayer


var current_music: RSEMusic


func play_music(music: RSEMusic) -> void:
	if music == current_music:
		return
	
	current_music = music
	print(music.name)
	
	if music.name == "None":
		stop()
		return
	
	if music.path_to_file == null or music.path_to_file == "":
		stop()
		return
	
	stream = load(music.path_to_file)
	play()
