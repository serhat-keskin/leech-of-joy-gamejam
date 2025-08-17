extends Node2D
@onready var attack_timer: Timer = $"../../attack_timer"
@onready var ray_cast_gun: RayCast2D = $"../../rays/RayCastGun"
@onready var ray_cast_melee: RayCast2D = $"../../rays/RayCastMelee"
@onready var Enemy: Enemy = $"../.."
const EnemyMove = preload("uid://cqw5u3or3f852")
var move_speed = 70
var chc
var dir
func enter(owner):
	chc = bool(randi() % 2)
	owner.anim_player.play("walk") 

func update(owner, delta):
	var player = get_tree().get_first_node_in_group("player")
	if not player:
		return
	dir = sign(player.global_position.x - owner.global_position.x)
	print(dir)
	if Enemy.ray_cast_detect.is_colliding():
		if(chc == true):
			if ray_cast_gun.is_colliding():
				owner.state_machine.change_state("attack_gun")
			else:
				owner.velocity.x = dir * move_speed
		else:
			if ray_cast_melee.is_colliding():
				owner.state_machine.change_state("attack")
			else:
				owner.velocity.x = dir * move_speed

func exit(owner):
	pass

	
