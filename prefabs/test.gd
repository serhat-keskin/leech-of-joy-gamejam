extends Node

@onready var level_music = preload("res://assets/musics/background musics/Boss music.wav")

func _ready() -> void:
	AudioManager.play_music(level_music)
