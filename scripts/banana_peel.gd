extends CharacterBody2D
@onready var banana_peel: CharacterBody2D = $"."

var gravity = Vector2(0, 500)  # pixels/sec^2
@onready var hp_bar: Node2D = $"."
var flag =0
@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	pass
	velocity = Vector2(100, -150)

func _process(delta):
	pass
	velocity += gravity * delta  # simulate gravity
	position += velocity * delta
func _physics_process(delta):
	if not is_on_floor():
		velocity += gravity * delta
	move_and_slide()  # Godot 4 style


func _on_body_entered(body):
	if body.is_in_group("enemy") && flag == 0:
		flag = 1
		sprite_2d.hide()
		collision_shape_2d.disabled = true
		if body == null:
			return
		
		var _body: Node2D = body
		if _body.has_node("HealthComponent"):
			var health = _body.get_node("HealthComponent")
			health.take_damage(2, 0)
		
		var anim = body.get_node("AnimationPlayer")	
		var start_rot = body.rotation_degrees
		var target_rot = start_rot + 90  # rotate +90 degrees
		var duration = 0.3
		body.velocity = Vector2.ZERO
		anim.pause()
		body.frozen = true
		await rotate_body_smoothly(body, 0, 90, 0.3)
		await get_tree().create_timer(0.5).timeout
		await rotate_body_smoothly(body, 90,0 , 0.3)
		body.frozen = false
		move_and_slide()
		#body.get_node("HPBar").damage(50,body)
		#if body.get_node("HPBar").dead == 0:
			#await get_tree().create_timer(0.4).timeout
			#await rotate_body_smoothly(body, 90,0 , 0.3)
			#body.frozen = false
			#danim.play() 
	set_process(false)

	
func rotate_body_smoothly(body: Node2D, from_deg: float, to_deg: float, duration: float):
	var elapsed := 0.0
	while elapsed < duration:
		elapsed += get_process_delta_time()
		var t: float = clamp(elapsed / duration, 0.0, 1.0)
		body.rotation_degrees = lerp(from_deg, to_deg, t)
		await get_tree().process_frame
	body.rotation_degrees = to_deg
