extends Area2D

signal can_climb_up
signal cannot_climb_up
signal can_climb_down
signal cannot_climb_down

func _init():
	add_to_group("Stairs")

func _on_body_entered(body):
	if body.name == "Player":
		emit_signal("can_climb_up")

func _on_body_exited(_body):
	emit_signal("cannot_climb_up")
