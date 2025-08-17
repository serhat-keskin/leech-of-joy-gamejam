extends Area2D

const hotbar = preload("uid://b3i8vltsahrhw")


func _on_body_entered(body):
	hotbar.add_to_hotbar("res://assets/items/Sprite-0001.png", 0)
	print("Banana picked up!")
	queue_free()  # remove banana from the scene
