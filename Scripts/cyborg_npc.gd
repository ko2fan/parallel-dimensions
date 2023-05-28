extends Area2D

signal can_talk_to_npc
signal cannot_talk_to_npc

func _init():
	add_to_group("NPCs")

func _on_body_entered(body):
	if body.name == "Player":
		can_talk_to_npc.emit(get_node("."))

func _on_body_exited(_body):
	emit_signal("cannot_talk_to_npc")
	

func start_conversation():
	get_tree().root.get_child(0).npc_conversation("Hello Patrick, I am sorry to hear about the death of your friend. Did you know he was not from this world? Go check his room!")
