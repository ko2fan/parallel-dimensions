extends CharacterBody2D

@export var moveSpeed = 300

@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var game = get_node("..")

var inventory : Array
var item_to_take = null
var npc_to_talk = null
var can_climb_up = false
var can_climb_down = false
var can_unlock = false
var can_travel_to_other_dimension = false

signal player_died

func _ready():
	animation_player.play("idle")
	
func _process(_delta):
	if Input.is_action_just_pressed("pickup"):
		if item_to_take != null:
			take_item(item_to_take)
			print("Took item: " + item_to_take.name)
		if npc_to_talk != null:
			talk_to_npc(npc_to_talk)
		if can_climb_up:
			global_position.y -= 96
		if can_climb_down:
			global_position.y += 96
		if can_unlock:
			for item in inventory:
				if item.name == "SymbolItem":
					get_node("../WorldOne/Door").queue_free()
		if can_travel_to_other_dimension:
			game.change_dimension()

func _physics_process(_delta):
	var force = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		force.x = -moveSpeed
	if Input.is_action_pressed("move_right"):
		force.x = moveSpeed
	velocity = force
	if force == Vector2.ZERO:
		animation_player.play("idle")
	else:
		if force.x > 0:
			sprite.flip_h = false
		else:
			sprite.flip_h = true
		animation_player.play("walk")
	move_and_slide()
		
	global_position = global_position.clamp(Vector2(0,0), get_viewport_rect().size)

func die():
	queue_free()
	
func set_item(item):
	item_to_take = item
	
func unset_item():
	item_to_take = null
	
func set_npc(npc):
	npc_to_talk = npc
	
func unset_npc():
	npc_to_talk = null

func set_climb_up():
	can_climb_up = true
	
func unset_climb_up():
	can_climb_up = false
	
func set_climb_down():
	can_climb_down = true
	
func unset_climb_down():
	can_climb_down = false
	
func set_unlock():
	can_unlock = true
	
func unset_unlock():
	can_unlock = false
	
func set_travel():
	can_travel_to_other_dimension = true
	
func unset_travel():
	can_travel_to_other_dimension = false

func take_item(item):
	inventory.append(item)
	item.get_node("Item").make_sprite_invisible()

func talk_to_npc(npc):
	npc.start_conversation()

func hookup_connections():
	var item_nodes = get_tree().get_nodes_in_group("Items")
	for item_node in item_nodes:
		print("Found Item: " + item_node.name)
		item_node.can_collect_item.connect(set_item)
		item_node.cannot_collect_item.connect(unset_item)
	
	var npc_nodes = get_tree().get_nodes_in_group("NPCs")
	for npc_node in npc_nodes:
		print("Found NPC: " + npc_node.name)
		npc_node.can_talk_to_npc.connect(set_npc)
		npc_node.cannot_talk_to_npc.connect(unset_npc)
	
	var stair_nodes = get_tree().get_nodes_in_group("Stairs")
	for stair_node in stair_nodes:
		print("Found stairs")
		stair_node.can_climb_up.connect(set_climb_up)
		stair_node.cannot_climb_up.connect(unset_climb_up)
		
	var door_nodes = get_tree().get_nodes_in_group("Doors")
	for door_node in door_nodes:
		print("Found door")
		door_node.can_unlock.connect(set_unlock)
		door_node.cannot_unlock.connect(unset_unlock)
		
	var portal_nodes = get_tree().get_nodes_in_group("Portals")
	for portal_node in portal_nodes:
		print("Found portal")
		portal_node.can_travel_dimension.connect(set_travel)
		portal_node.cannot_travel_dimension.connect(unset_travel)
