extends Area2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var knockback = 2000;
@export var damage = 3;
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $"../AudioStreamPlayer2D"
func _ready() -> void:
	animation_player.play("hit")
var oscalex
var oscaley

func exit():
	queue_free()
	

func _on_body_entered(body: Node2D) -> void:
	if body.has_node("AnimatedSprite2D") and body.is_in_group("enemy"):
		var sprite = body.get_node("AnimatedSprite2D")
		var orgposy= sprite.position.y
		oscalex=sprite.scale.x 
		oscaley=sprite.scale.y
		var original_height = sprite.scale.y
		sprite.scale.x = 3
		sprite.scale.y = 0.33
		var height_diff = (original_height - sprite.scale.y) * sprite.sprite_frames.get_frame_texture(sprite.animation, sprite.frame).get_height() / 2
		sprite.position.y += height_diff


	

	if body.has_node("HealthComponent") and body.is_in_group("enemy"):
		var kb = 0


		# ???????????
		if self.get_parent().scale.x == 1:
			kb = +1
		else:
			kb = -1
	
		var health = body.get_node("HealthComponent")
		health.take_damage(damage, knockback * kb)
