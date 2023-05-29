extends Control

@onready var icon = preload("res://Scenes/icon.tscn")

var icon_instance

func _ready():
	icon_instance = icon.instantiate()
		
func show_icon():
	add_child(icon_instance)
	icon_instance.global_position = Vector2(90, 700)
