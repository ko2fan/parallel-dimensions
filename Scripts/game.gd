extends Node2D

@onready var world = preload("res://Scenes/world_one.tscn")
@onready var world_two = preload("res://Scenes/world_two.tscn")
@onready var npc_text = preload("res://Scenes/npc_text.tscn")

var current_world

func _ready():
	change_dimension()
	
func npc_conversation(text):
	var text_instance = npc_text.instantiate()
	add_child(text_instance)
	text_instance.global_position = Vector2(600, 500)
	text_instance.get_node("Label").text = text

func change_dimension():
	var world_instance
	if current_world:
		remove_child(current_world)
		if current_world.name == "WorldOne":
			world_instance = world_two.instantiate()
		else:
			world_instance = world.instantiate()
		current_world.queue_free()
	else:
		world_instance = world.instantiate()
	current_world = world_instance
	add_child(world_instance)
	get_node("Player").hookup_connections()
