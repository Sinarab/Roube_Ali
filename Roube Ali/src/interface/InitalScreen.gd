extends Control

func _on_InitalScreen_tree_entered() -> void:
	get_tree().paused = false
	PlayerData.peixitos = 0
	PlayerData.loses = 0

