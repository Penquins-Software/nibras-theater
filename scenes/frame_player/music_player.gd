class_name MusicPlayer
extends AudioStreamPlayer


var current_music: RSEMusic

const transitition_seconds: float = 1.0
const min_db: float = linear_to_db(0)

var increase_time: float = 0.0
var decrease_time: float = 0.0
var current_linear: float = 1.0


#func _process(delta):
	#if increase_time > 0:
		#increase_time -= delta
		#volume_db = linear_to_db(1.0 - increase_time)
	#
	#if decrease_time > 0:
		#decrease_time -= delta
		#if decrease_time <= 0:
			#decrease_time = 0
			#stop()
		#var db = linear_to_db(decrease_time)
		#if db <= volume_db:
			#volume_db = db


func play_music(music: RSEMusic) -> void:
	if music == current_music:
		if not playing:
			play()
		return
	
	current_music = music
	#print(music.name)
	
	if music.name == "None":
		stop()
		stream = null
		return
	
	if music.path_to_file == null or music.path_to_file == "":
		stop()
		return
	
	stream = load(music.path_to_file)
	play()

#
#func _play() -> void:
	#increase_time = transitition_seconds
	#decrease_time = 0
	#volume_db = min_db
	#play()
#
#
#func _stop() -> void:
	#increase_time = 0
	#decrease_time = transitition_seconds
