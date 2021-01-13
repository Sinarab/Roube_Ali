extends Button

onready var scene_tree = get_tree()

func _on_RetryBtn_button_up() -> void:
	PlayerData.peixitos = 0
	get_tree().reload_current_scene()
