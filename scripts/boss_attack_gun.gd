extends Node
class_name BossAttack_Gun
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $"../../AudioStreamPlayer2D"
@onready var Enemy: Enemy = $"../.."
const EnemyCombatGun = preload("uid://cfi61m6ykggma")
@onready var attack_timer: Timer = $"../../idle_timer"
@onready var walk: Enemy_move = $"../walk"
const AMMO = preload("uid://cvsgyx87a3y1")
@export var Backoff = 1
@onready var combat: Node2D = $"../combat"
@onready var ammopos: Node2D = $"../../ammopos"

func enter(owner):
	print("BOSS ENTERED ATTACK GUN")
	owner.anim_player.play("shoot")
	attack_timer.wait_time = 2
	if not attack_timer.timeout.is_connected(_on_attack_timer_timeout):
		attack_timer.timeout.connect(_on_attack_timer_timeout.bind(owner))
	attack_timer.start()
func update(owner, delta):
	owner.position.x += Backoff * walk.direction
func _on_attack_timer_timeout(owner):
	owner.state_machine.change_state("combat")

func shoot():
	audio_stream_player_2d.play()
	var new_bullet = AMMO.instantiate()
	if owner.sprite.flip_h == false:
		ammopos.position.x = 30
	else:
		ammopos.position.x = -30
	print("COMBAT DIR IS")
	print(combat.dir)
	new_bullet.dir = combat.dir
	new_bullet.position = ammopos.position
	add_child(new_bullet)
