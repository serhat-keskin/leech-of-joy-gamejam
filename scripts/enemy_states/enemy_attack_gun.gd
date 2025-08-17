extends Node
class_name EnemyAttack_Gun
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $"../../AudioStreamPlayer2D"
@onready var ray_cast_player: RayCast2D = $"../../rays/RayCastPlayer"
@onready var Enemy: Enemy = $"../.."
const EnemyCombatGun = preload("uid://cfi61m6ykggma")
@onready var attack_timer: Timer = $"../../idle_timer"
@onready var walk: Enemy_move = $"../walk"
const AMMO = preload("uid://cvsgyx87a3y1")
@export var Backoff = 0
@onready var combat: Node2D = $"../combat"
@onready var ammopos: Node2D = $"../../ammopos"

func enter(owner):
	print("Entered attack state")
	owner.anim_player.stop()
	owner.anim_player.play("attack")

func exit(owner):
	print("EXITED ATTACCKK STATEE")
func shootAgain():
	if Enemy.ray_cast_player.is_colliding():
			owner.state_machine.change_state("attack_gun")
	else:
			owner.state_machine.change_state("combat")
		
func shoot():
	audio_stream_player_2d.play()
	var new_bullet = AMMO.instantiate()
	print(ammopos.position.x)
	if owner.sprite.flip_h == false:
		ammopos.position.x = 30
	else:
		ammopos.position.x = -30
	new_bullet.dir = combat.dir
	new_bullet.position = ammopos.position
	add_child(new_bullet)
