extends AnimatedSprite2D


@onready var player_movement = $"../PlayerMovement"
@onready var player = $".."
@onready var attack_node = $"../Attack"

enum AnimationState {
	WALKING,
	ATTACKING,
	IDLING
}

var state: AnimationState = AnimationState.IDLING
func _ready() -> void:
	change_animation("idle")
	self.play()
	

func change_animation(anim):
	if self.animation != anim:
		self.animation = anim
		self.play()

func _process(delta: float) -> void:
	if attack_node.is_attacking:
		change_animation("attack")
	elif player.is_on_floor() and player.velocity.x != 0:
		change_animation("walk")
	else:
		change_animation("idle")
