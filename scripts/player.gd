extends CharacterBody2D
class_name MyPlayer

@onready var anim_player := $AnimationPlayer
@onready var sprite := $AnimatedSprite2D

@export var IS_DEBUG: bool = false

func _ready():
	var health_component = get_node_or_null("HealthComponent")
	if health_component:
		health_component.on_ran_out_of_health.connect(_on_game_over)

func _on_game_over():
	if IS_DEBUG:
		print("Player died but death is disabled (God Mode)")
	else:
		get_tree().change_scene_to_file("res://GameSystem/GameOver.tscn")

func _process(delta: float) -> void:
	pass
