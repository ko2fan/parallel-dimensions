extends Area2D

signal can_collect_item
signal cannot_collect_item

@onready var icon = preload("res://Scenes/icon.tscn")

func _init():
	add_to_group("Items")

func _on_body_entered(body):
	if body.name == "Player":
		can_collect_item.emit(get_node(".."))

func _on_body_exited(_body):
	emit_signal("cannot_collect_item")

func make_sprite_invisible():
	get_node("..").get_node("Sprite2D").set_visible(false)
