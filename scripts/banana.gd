extends Area2D


@onready var hotbar = $"../Hotbar"
@export var icon: Texture2D
func _on_body_entered(body):
	if hotbar.current_index < hotbar.hotbar_slots.size():
		hotbar.add_to_hotbar("res://assets/items/Sprite-0001.png", 0)
		print("Banana picked up!")
		queue_free()
	pass
