extends Area2D
@onready var movement = $"../../PlayerMovement"

@export var damage = 1
@export var knockback = 200

func _on_body_entered(body: Node2D) -> void:
	var kb_dir = 0
	if movement.facing == 0:
		kb_dir = -1
	else:
		kb_dir = 1
	
	if body.has_node("HealthComponent") and body.is_in_group("enemy"):
		var health_component = body.get_node("HealthComponent") 
		health_component.take_damage(damage, knockback * kb_dir)
