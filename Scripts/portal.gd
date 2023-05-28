extends Area2D

signal can_travel_dimension
signal cannot_travel_dimension

func _init():
	add_to_group("Portals")

func _on_body_entered(body):
	if body.name == "Player":
		emit_signal("can_travel_dimension")


func _on_body_exited(_body):
	emit_signal("cannot_travel_dimension")
