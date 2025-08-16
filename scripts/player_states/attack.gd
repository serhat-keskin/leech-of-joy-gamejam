extends Node2D

var can_attack = true;
var fart_bag_scene = preload("res://prefabs/fart_bag.tscn")


func enter(owner):
	print("Enter attack")
	pass
	
	
func update(owner, delta):
	if can_attack and Input.is_action_just_pressed("attack"):
		print("Playing")
		can_attack = false
		$"../../AnimationPlayer".play("ATTACK");
		

	if can_attack and Input.is_action_just_pressed("throw"):
		var fart = fart_bag_scene.instantiate()
		owner.get_parent().add_child(fart)
		fart.global_position = owner.global_position
		
		var vel = 0;
		
		print("Player facing enum value: ", owner.facing)
		print("CharFacing.LEFT = ", owner.CharFacing.LEFT, ", CharFacing.RIGHT = ", owner.CharFacing.RIGHT)
		
		# CharFacing.LEFT = 0, CharFacing.RIGHT = 1
		if owner.facing == owner.CharFacing.RIGHT:
			vel = 500; # facing right
			print("Determined: throwing RIGHT with vel: ", vel)
		else:
			vel = -500; # facing left
			print("Determined: throwing LEFT with vel: ", vel)
			

		var throw_velocity = Vector2(vel, -200)
		print("Final throw velocity: ", throw_velocity)
		fart.throw(throw_velocity)
		
		if owner.velocity.x != 0:
			owner.state_machine.change_state("Walk")
		else:
			owner.state_machine.change_state("Idle")
		
	
func exit(owner):
	pass


func _on_attack_cooldown_timeout() -> void:
	can_attack = true


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	pass # Replace with function body.
