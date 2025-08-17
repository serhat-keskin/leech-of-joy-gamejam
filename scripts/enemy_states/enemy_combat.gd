extends Node2D
@onready var Enemy: Enemy = $"../.."
@onready var attack_timer: Timer = $"../../attack_timer"
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $"../../AudioStreamPlayer2D"

var move_speed = 70

func enter(owner):
	audio_stream_player_2d.play()
	owner.anim_player.play("walk") 

func update(owner, delta):
	var player = get_tree().get_first_node_in_group("player")
	if not player:
		return
	var dir = sign(player.global_position.x - owner.global_position.x)
	if not Enemy.ray_cast_player.is_colliding():
		owner.velocity.x = dir * move_speed
		owner.move_and_slide() 
	else:
		owner.velocity.x = 0
		owner.state_machine.change_state("attack")

func exit(owner):
	pass

	
