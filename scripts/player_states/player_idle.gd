extends Node

func enter(owner):
	print("Entered Idle")
	owner.anim_player.play("idle")


func update(owner, delta):
	if Input.is_action_pressed("right") || Input.is_action_pressed("left"):
		owner.state_machine.change_state("Walk")
	
	if Input.is_action_just_pressed("attack") or Input.is_action_just_pressed("throw"):
		owner.state_machine.change_state("Attack")

func exit(owner):
	print("Exited Idle")
	
