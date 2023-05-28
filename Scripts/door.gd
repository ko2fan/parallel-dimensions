extends StaticBody2D

signal can_unlock
signal cannot_unlock

func _init():
	add_to_group("Doors")
	
func _on_area_2d_body_entered(body):
	if body.name == "Player":
		emit_signal("can_unlock")


func _on_area_2d_body_exited(_body):
	emit_signal("cannot_unlock")
