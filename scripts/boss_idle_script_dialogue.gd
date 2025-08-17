extends Node2D  # AnimationPlayer'ı içeren node

@onready var anim_player: AnimationPlayer = $AnimatedSprite2D/AnimationPlayer

func _ready():
	anim_player.play("idle")
