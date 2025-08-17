extends Control

var hotbar_slots = []
var hotbar_items = [-1, -1, -1]
var current_index = 0
const BANANA_PEEL = preload("uid://tsag137pcggo")
const HAMMER = preload("uid://dlh2mwi23ohm6")

func _ready():
	var grid = $GridContainer
	hotbar_slots = []
	for child in grid.get_children():
		if child is Button:
			hotbar_slots.append(child)

func add_to_hotbar(texture_path, index):
	if current_index < hotbar_slots.size():
		var tex = load(texture_path)
		hotbar_slots[current_index].icon = tex 
		hotbar_items[current_index] = index
		current_index += 1


func _process(delta):
	if Input.is_action_just_pressed("hotbar_1"):
		use_hotbar_item(0)
	if Input.is_action_just_pressed("hotbar_2"):
		use_hotbar_item(1)
	if Input.is_action_just_pressed("hotbar_3"):
		use_hotbar_item(2)

func use_hotbar_item(slot_index):
	if hotbar_items[slot_index] == 0:
		var item_instance = BANANA_PEEL.instantiate()
		get_parent().add_child(item_instance)
	elif hotbar_items[slot_index] == 1:
		var item_instance = HAMMER.instantiate()
		get_parent().add_child(item_instance)
	else:
		return
	hotbar_slots[slot_index].icon = null
	hotbar_items[slot_index] = -1
