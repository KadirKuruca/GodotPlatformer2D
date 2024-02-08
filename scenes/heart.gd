extends Area2D

func _on_body_entered(body):
	queue_free()
	Events.coin_collected.emit()
	if get_tree().get_nodes_in_group("Hearts").size() == 1:
		Events.level_completed.emit()
