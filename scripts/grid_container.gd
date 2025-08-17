extends GridContainer

var hotbar_slots = []
var hotbar_items = [-1, -1, -1]
var current_index = 0
const BANANA_PEEL = preload("uid://tsag137pcggo")
const HAMMER = preload("uid://dlh2mwi23ohm6")
func _ready():
	hotbar_slots = get_children()  # TextureRect nodes

func add_to_hotbar(texture, index):
	if current_index < hotbar_slots.size():
		var tex = load(texture)
		hotbar_slots[current_index].texture = tex  # use `.texture` for TextureRect
		hotbar_items[current_index] = index
		current_index += 1

func _process(delta):
	if Input.is_action_just_pressed("hotbar_1"):
		use_hotbar_item(0)

func use_hotbar_item(slot_index):
	if hotbar_items[slot_index] == 0:
		var item_instance = BANANA_PEEL.instantiate()
		get_parent().add_child(item_instance)
	elif hotbar_items[slot_index] == 1:
		var item_instance = HAMMER.instantiate()
		get_parent().add_child(item_instance)
	else:
		return

	hotbar_slots[slot_index].texture = null
	hotbar_items[slot_index] = -1
