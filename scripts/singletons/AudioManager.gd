extends Node

var music_player: AudioStreamPlayer2D
var current_music: AudioStream = null

func _ready():
	music_player = AudioStreamPlayer2D.new()
	add_child(music_player)
	music_player.autoplay = false

func play_music(music: AudioStream):
	# Eğer farklı bir müzik çalıyorsa önce durdur
	if music_player.playing:
		music_player.stop()
	current_music = music
	music_player.stream = music
	music_player.play()
