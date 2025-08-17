extends Area2D

const lines: Array[String] = [
	"Merhaba!",
	"Deneme 1-2...",
	"SDFSKDGJSDKGSSDKFGHSDKJGSHDFGSD",
	"AAAAAAAAAAAAAAA!!!",
]

func _input(event):
	if event.is_action_pressed("interact"):
		DialogueManager.start_dialog(global_position, lines)
