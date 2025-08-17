extends Node
class_name EnemyAttack
@onready var attack_area: Area2D = $"../../AttackArea"
@onready var attack_timer: Timer = $"../../idle_timer"
@onready var walk: Enemy_move = $"../walk"

func enter(owner):
	attack_area.set_deferred("monitoring", true)
	owner.anim_player.play("attack")
	attack_timer.wait_time = 1.1


	if not attack_timer.timeout.is_connected(_on_attack_timer_timeout):
		attack_timer.timeout.connect(_on_attack_timer_timeout.bind(owner))
	attack_timer.start()



func _on_attack_timer_timeout(owner):
	owner.state_machine.change_state("combat")
	
func update(owner, delta):
	owner.velocity = Vector2.ZERO
	var overlapped = attack_area.get_overlapping_areas()
	
func exit(owner):
	#print("Exiting attack")
	attack_area.set_deferred("monitoring", false)
	if attack_timer.timeout.is_connected(_on_attack_timer_timeout):
		attack_timer.timeout.disconnect(_on_attack_timer_timeout)
