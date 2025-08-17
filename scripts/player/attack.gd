extends Node2D

@onready var attack_animation_player = $AttackHitboxAnimationPlayer
@onready var timer = $AttackCooldown
@onready var harvest = $"../Harvest"

var hammer = preload("res://prefabs/hammer.tscn")
var bomb = preload("res://prefabs/fart_bag.tscn")
var banana = preload("res://prefabs/banana_peel.tscn")
var can_attack = true
var is_attacking = false

# Costs out of 2.0
const BANANA_COST = 0.5
const BOMB_COST = 0.5
const HAMMER_COST = 0.5

enum WeaponSelection {
	HAMMER,
	BOMB,
	BANANA,
}

func _ready() -> void:
	$"../CanvasLayer/Label".text = get_weapon_text(weapon_selection)
	
@export var weapon_selection = WeaponSelection.BANANA;

func get_weapon_text(weapon: WeaponSelection) -> String:
		var text;
		var cost;
		match weapon_selection:
			WeaponSelection.BOMB:
				text = "Bomb"
				cost = BOMB_COST
			WeaponSelection.HAMMER:
				text = "Hammer"
				cost = HAMMER_COST
			WeaponSelection.BANANA:
				text = "Banana"
				cost = BANANA_COST
		
		var percentage = cost * 100 / 2
		return text + " (Cost: " + str(percentage) + "%)";
			
	
func _process(delta: float) -> void:
	if Input.is_action_pressed("attack"):
		attack_animation_player.play("melee")
		is_attacking = true
		can_attack = false
	
	# Hammer
	if Input.is_action_just_pressed("special") and can_attack and weapon_selection == WeaponSelection.HAMMER and harvest.power >= HAMMER_COST:
		can_attack = false
		var inst = hammer.instantiate()
		
		add_child(inst)
		harvest.power -= HAMMER_COST
	
	# Bomb
	if Input.is_action_just_pressed("special") and can_attack and weapon_selection == WeaponSelection.BOMB and harvest.power >= BOMB_COST:
		can_attack = false
		var inst = bomb.instantiate()
		
		get_tree().current_scene.add_child(inst)
		
		inst.global_position = global_position
		
		var vel = 0
		if $"../PlayerMovement".facing == 1:
			vel = 500
		else:
			vel = -500
		inst.get_node("RigidBody2D").linear_velocity.x = vel
		harvest.power -= BOMB_COST
		
	# Banana	
	if Input.is_action_just_pressed("special") and can_attack and weapon_selection == WeaponSelection.BANANA and harvest.power >= BANANA_COST:
		can_attack = false
		
		var inst = banana.instantiate()
		get_tree().current_scene.add_child(inst)
		inst.global_position = global_position
		harvest.power -= BANANA_COST
		
		
	if Input.is_action_just_pressed("next_special"):
		match weapon_selection:
			WeaponSelection.HAMMER:
				weapon_selection = WeaponSelection.BOMB
				print("Switched to BOMB")
			WeaponSelection.BOMB:
				weapon_selection = WeaponSelection.BANANA
				print("Switched to BANANA")
			WeaponSelection.BANANA:
				weapon_selection = WeaponSelection.HAMMER
				print("Switched to HAMMER")
	
		
		$"../CanvasLayer/Label".text = get_weapon_text(weapon_selection)
		

func _on_attack_cooldown_timeout() -> void:
	can_attack = true


func _on_attack_hitbox_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "melee":
		is_attacking = false
