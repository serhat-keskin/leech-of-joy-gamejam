extends Node

@export var speed = 100

func enter(owner):
	print("Entered Walk")
	
	if not DialogueManager.is_dialog_active:
		owner.anim_player.play("walk")

func update(owner, delta):

		
		

	if owner.velocity.x == 0:
		owner.state_machine.change_state("Idle")
		
	if Input.is_action_just_pressed("attack"):
		owner.state_machine.change_state("Attack")

func exit(owner):
	print("Exited Walk")
