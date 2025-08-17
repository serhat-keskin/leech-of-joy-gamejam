extends Node2D

@onready var menu_music = preload("res://assets/musics/background musics/Intro music.wav")

func _ready():
	AudioManager.play_music(menu_music)
