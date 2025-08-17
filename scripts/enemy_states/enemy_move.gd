extends Node
class_name Enemy_move

@onready var idle_timer: Timer = $"../../idle_timer"
@onready var Enemy: Enemy = $"../.."
@onready var idle: Node2D = $"../idle"

var direction = 1

func enter(owner):
	direction = Enemy.direction
	direction *= -1
	owner.anim_player.play("walk")
	idle_timer.wait_time = randomiser()

func update(owner, delta):
	owner.velocity.x = Enemy.speed * direction
	var on_timeout = func():
		if owner.state_machine.current_state is Enemy_move:
			owner.state_machine.change_state("idle")
	owner.get_node("idle_timer").timeout.connect(on_timeout)
	if Enemy.ray_cast_detect.is_colliding():
		owner.state_machine.change_state("combat")
	owner.move_and_slide()
func exit(owner):
	idle_timer.stop()
	pass

func randomiser():
	var randomN = [6,7.8,9,10]
	randomN.shuffle()
	return randomN.front()
