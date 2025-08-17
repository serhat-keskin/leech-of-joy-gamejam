extends Enemy

func _on_health_component_on_death() -> void:
	call_deferred("_load_victory_scene")
	
func _load_victory_scene():
	get_tree().change_scene_to_file("res://GameSystem/Victory.tscn")
	queue_free()
