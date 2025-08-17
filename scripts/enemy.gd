extends CharacterBody2D
class_name Enemy
@export var speed = 50
@onready var anim_player := $AnimationPlayer
@onready var state_machine := $States 
@onready var sprite := $AnimatedSprite2D
@onready var ray_cast_right: RayCast2D = $rays/RayCastRight
@onready var ray_cast_left: RayCast2D = $rays/RayCastLeft
@onready var ray_cast_player: RayCast2D = $rays/RayCastPlayer
@onready var ray_cast_detect: RayCast2D = $rays/RayCastDetect
@onready var rays: Node2D = $rays
@onready var attack_area: Area2D = $AttackArea
@onready var ammopos: Node2D = $ammopos
var direction = 1
var gravity = 10
var frozen = false

func _ready():
	direction = -1
	sprite.flip_h = true
	rays.scale.x = -1
	if attack_area:
		attack_area.scale.x = -1
	state_machine.initialize($States)

func _process(delta: float):
	if ray_cast_right.is_colliding():
		direction = 1
	elif ray_cast_left.is_colliding():
		direction = -1
	if velocity.x > 0:
		sprite.flip_h = false
		rays.scale.x = 1
		if attack_area:
			attack_area.scale.x = 1
	elif velocity.x < 0:
		sprite.flip_h = true
		rays.scale.x = -1
		if attack_area:
			attack_area.scale.x = -1

func _physics_process(delta):
	if not frozen:
		if state_machine.current_state and state_machine.current_state.has_method("update"):
			state_machine.current_state.update(self, delta)
		velocity.y += gravity
		
	move_and_slide()


func _on_health_component_on_death() -> void:
	self.queue_free()
