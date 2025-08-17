extends Node

@onready var text_box_scene = preload("res://DialogueSystem/text_box.tscn")

var dialog_lines: Array = []
var current_line_index: int = 0
var text_box: Node = null
var text_box_position: Vector2
var is_dialog_active: bool = false
var can_advance_line: bool = false

signal dialog_finished  # Her dialog satırı bittiğinde tetiklenecek

func start_dialog(position: Vector2, lines: Array) -> Node:
	if is_dialog_active:
		return self  # Zaten aktif, sadece referans dön
	
	dialog_lines = lines
	text_box_position = position
	current_line_index = 0
	is_dialog_active = true
	_show_text_box()
	return self

func _show_text_box():
	text_box = text_box_scene.instantiate()
	text_box.finished_displaying.connect(_on_text_box_finished_displaying)
	get_tree().root.add_child(text_box)
	text_box.global_position = text_box_position
	text_box.display_text(dialog_lines[current_line_index])
	can_advance_line = false

func _on_text_box_finished_displaying():
	can_advance_line = true

func _unhandled_input(event):
	if event.is_action_pressed("interact") and is_dialog_active and can_advance_line:
		text_box.queue_free()
		current_line_index += 1
		if current_line_index >= dialog_lines.size():
			is_dialog_active = false
			emit_signal("dialog_finished")  # ✅ Bu signal await ile bekleniyor
			return
		_show_text_box()
