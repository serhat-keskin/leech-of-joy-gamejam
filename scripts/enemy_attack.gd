extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.has_node("HealthComponent") and body.is_in_group("player"):
		var health = body.get_node("HealthComponent")
		health.take_damage(1, 100)
		
