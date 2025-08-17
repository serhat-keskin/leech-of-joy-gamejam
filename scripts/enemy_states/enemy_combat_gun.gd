extends Node2D
@onready var Enemy: Enemy = $"../.."
@onready var attack_timer: Timer = $"../../attack_timer"

var move_speed = 50
var dir
func enter(owner):
	print("Entered combat state")
	owner.anim_player.play("walk") 

func update(owner, delta):
	var player = get_tree().get_first_node_in_group("player")
	if not player:
		return
	dir = sign(player.global_position.x - owner.global_position.x)
	if not Enemy.ray_cast_player.is_colliding():
		owner.velocity.x = dir * move_speed
		owner.move_and_slide() # bu ne yapıyor öğren
	else:
		owner.velocity.x = 0
		owner.state_machine.change_state("attack_gun")


func exit(owner):
	print("Exited Combat State")
	pass

	
