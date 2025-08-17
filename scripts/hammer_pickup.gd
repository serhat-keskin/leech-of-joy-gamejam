extends Area2D
@export var move_distance: float = 30.0
@export var move_duration: float = 1.0

var original_position: Vector2
@onready var hotbar: Control = $"../Hotbar"

@export var icon: Texture2D
func _on_body_entered(body):
	if hotbar.current_index < hotbar.hotbar_slots.size():
		hotbar.add_to_hotbar("res://assets/hammer.png", 1)
		print("Hammer picked up!")
		queue_free()
	pass


func _ready():
	original_position = global_position
	move_up()

func move_up():
	var tween = create_tween()
	tween.tween_property(self, "global_position", original_position + Vector2(0, -move_distance), move_duration)
	tween.connect("finished", Callable(self, "_on_move_up_finished"))

func _on_move_up_finished():
	await get_tree().create_timer(0.1).timeout
	move_down()

func move_down():
	var tween = create_tween()
	tween.tween_property(self, "global_position", original_position, move_duration)
	tween.connect("finished", Callable(self, "_on_move_down_finished"))

func _on_move_down_finished():
	await get_tree().create_timer(0.1).timeout
	move_up()
