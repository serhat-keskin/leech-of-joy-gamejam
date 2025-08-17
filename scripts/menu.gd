extends CanvasLayer

func _ready():
	visible = false
	process_mode =Node.PROCESS_MODE_WHEN_PAUSED

func toggle():
	visible = !visible
	get_tree().paused = visible
