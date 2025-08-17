extends AnimationPlayer


@onready var player_movement = $"../PlayerMovement"
@onready var player = $".."
@onready var attack_node = $"../Attack"

enum AnimationState {
	WALKING,
	ATTACKING,
	IDLING
}

var state: AnimationState = AnimationState.IDLING

func _process(delta: float) -> void:
	if attack_node.is_attacking:
		self.play("attack")
	elif player.is_on_floor() and player.velocity.x != 0:
		self.play("walk")
	else:
		self.play("idle")
