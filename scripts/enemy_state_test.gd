extends Node2D

const HAMMER_SCENE = preload("uid://biorove2yovj5")

# Function to spawn a hammer
func spawn_hammer(pos: Vector2):
	var hammer = HAMMER_SCENE.instantiate()
	hammer.global_position = pos
	get_tree().current_scene.add_child(hammer)

# Call it from _ready() or some other function
func _ready():
	spawn_hammer(Vector2(100, 200))
	spawn_hammer(Vector2(200, 250))
	spawn_hammer(Vector2(300, 300))
