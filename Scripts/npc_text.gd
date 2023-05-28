extends Control


func _on_button_pressed():
	queue_free()

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		queue_free()
