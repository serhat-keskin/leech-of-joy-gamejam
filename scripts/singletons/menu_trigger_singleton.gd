extends Node
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		print("Menu!")
		Menu.toggle()
