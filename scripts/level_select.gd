extends CanvasLayer

func _on_level1_pressed():
	get_tree().change_scene_to_file("res://GameSystem/Level1.tscn")

func _on_level2_pressed():
	get_tree().change_scene_to_file("res://GameSystem/Level2.tscn")

func _on_boss_pressed():
	get_tree().change_scene_to_file("res://GameSystem/LevelBoss.tscn")

func _on_back_pressed():
	get_tree().change_scene_to_file("res://GameSystem/StartScene.tscn")
