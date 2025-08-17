extends Node

@onready var idle_timer: Timer = $"../../idle_timer"
@onready var Enemy: Enemy = $"../.."

func enter(owner):
	owner.anim_player.play("idle")
	owner.velocity = Vector2.ZERO
	var rand = randomiser()
	idle_timer.wait_time = rand

	if not idle_timer.timeout.is_connected(_on_idle_timer_timeout):
		idle_timer.timeout.connect(_on_idle_timer_timeout.bind(owner))
	idle_timer.start()

func randomiser():
	var randomN = [1.5, 2, 2.5,3]
	randomN.shuffle()
	return randomN.front()

func _on_idle_timer_timeout(owner):
	owner.state_machine.change_state("walk")

func update(owner, delta):
	if Enemy.ray_cast_detect.is_colliding():
		#print("Player detected!.")
		owner.state_machine.change_state("combat")

func exit(owner):
	idle_timer.stop()
	if idle_timer.timeout.is_connected(_on_idle_timer_timeout):
		idle_timer.timeout.disconnect(_on_idle_timer_timeout)
