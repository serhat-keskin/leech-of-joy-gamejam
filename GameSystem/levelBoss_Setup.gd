extends Node2D

@onready var level_music = preload("res://assets/musics/background musics/Boss intro.wav")

func _ready():
	AudioManager.play_music(level_music)
