extends Button

@onready var musicPlayer =	$"../../../../../AudioStreamPlayer"

func _ready() -> void:
	musicPlayer.play()

func _process(delta: float) -> void:
	if not musicPlayer.playing:
		musicPlayer.play()

func _pressed():
	musicPlayer.stop()
	var next_scene = preload("res://GameSystem/LevelSelect.tscn")
	get_tree().change_scene_to_packed(next_scene)
